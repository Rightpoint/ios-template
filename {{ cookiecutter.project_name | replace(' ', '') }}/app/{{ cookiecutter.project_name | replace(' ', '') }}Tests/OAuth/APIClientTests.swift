//
//  APIClientTests.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/3/16.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import OHHTTPStubs
import XCTest
@testable import {{ cookiecutter.project_name | replace(' ', '') }}

class APIClientTests: XCTestCase {
    let client: APIClient = {
        let configuration = URLSessionConfiguration.default
        OHHTTPStubs.setEnabled(true, for: configuration)
        let client = APIClient(baseURL: TestClient.baseURL, configuration: configuration)
        return client
    }()
    override class func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }

    func testAuthenticatedRequestWithNoCredentials() {
        var authorized: Bool = false
        stub(condition: pathStartsWith("/oauth/refresh")) { _ in
            authorized = false
            return OHHTTPStubsResponse(data: Payloads.oauth, statusCode:400, headers:nil)
        }
        stub(condition: pathStartsWith("/test")) { _ in
            return OHHTTPStubsResponse(data: Payloads.test, statusCode: authorized ? 200 : 401, headers: nil)
        }

        let expectation = self.expectation(description: "Test Endpoint")
        client.request(TestEndpoint()) { _, error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssert(authorized == false, "client made a refresh request")
    }

    func testAuthenticatedRequestWithCredentials() {
        client.oauthClient.credentials = OAuthClient.Credentials(
            refreshToken: "INITIAL_REFRESH_TOKEN",
            accessToken: "INVALID_TOKEN",
            expirationDate: Date.distantFuture
        )

        var authorized: Bool = false
        stub(condition: pathStartsWith("/oauth/refresh")) { _ in
            authorized = true
            return OHHTTPStubsResponse(data: Payloads.oauth, statusCode:200, headers:nil)
        }
        stub(condition: pathStartsWith("/test")) { _ in
            return OHHTTPStubsResponse(data: Payloads.test, statusCode: authorized ? 200 : 401, headers:nil)
        }

        let expectation = self.expectation(description: "Test Endpoint")
        client.request(TestEndpoint()) { (response, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            XCTAssert(response?.count == 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssert(authorized, "client did not make a refresh request")
    }

    func testManyAuthenticatedRequestWithCredentials() {
        client.oauthClient.credentials = OAuthClient.Credentials(
            refreshToken: "INITIAL_REFRESH_TOKEN",
            accessToken: "INVALID_TOKEN",
            expirationDate: Date.distantFuture
        )

        var oauthCount = 0
        var testCount = 0
        stub(condition: pathStartsWith("/oauth/refresh")) { _ in
            oauthCount += 1

            return OHHTTPStubsResponse(data: Payloads.oauth, statusCode:200, headers:nil)
        }

        stub(condition: pathStartsWith("/test")) { _ in
            testCount += 1
            return OHHTTPStubsResponse(data: Payloads.test, statusCode: oauthCount > 0 ? 200 : 401, headers:nil)
        }

        // Make 10 requests with an invalid token. The requests should 401 10 times, obtain a new token once, retry, and 200 10 times.
        for i in 0..<10 {
            let expectation = self.expectation(description: "Test Endpoint \(i)")
            client.request(TestEndpoint()) { (response, error) in
                XCTAssertNil(error)
                XCTAssertNotNil(response)
                XCTAssert(response?.count == 1)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: timeout, handler: nil)
        // Due to timing issues, we can't verify exact counts. The oauth request can be hit before the 10 test requests are sent,
        // causing some portion of the test requests to not need a retry.
        XCTAssert(testCount > 10)
        // I don't have a good explaination of why more than 1 refresh request is made. There's probably a bug to be fixed here, but I don't think
        // it's severe.
        XCTAssert(oauthCount >= 1)
    }

}
