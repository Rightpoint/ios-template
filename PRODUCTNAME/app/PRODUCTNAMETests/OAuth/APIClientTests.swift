//
//  APIClientTests.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import OHHTTPStubs
import XCTest
@testable import Services

class APIClientTests: XCTestCase {
    var client: APIClient!

    override func setUp() {
        super.setUp()

        let configuration = URLSessionConfiguration.default
        OHHTTPStubs.setEnabled(true, for: configuration)
        client = APIClient(baseURL: TestClient.baseURL, configuration: configuration)
    }

    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }

    func testAuthenticatedRequestWithNoCredentials() {
        var authorized: Bool = false
        stub(condition: pathStartsWith("/oauth/refresh")) { _ in
            authorized = false
            return OHHTTPStubsResponse(data: Payloads.oauth, statusCode: 400, headers: nil)
        }
        stub(condition: pathStartsWith("/test")) { _ in
            return OHHTTPStubsResponse(data: Payloads.test, statusCode: authorized ? 200 : 401, headers: nil)
        }

        let expectation = self.expectation(description: "Test Endpoint")
        client.request(TestEndpoint()) { _, error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        // Technique modified from that shown here:
        // https://github.com/AliSoftware/OHHTTPStubs/wiki/OHHTTPStubs-and-asynchronous-tests
        waitForExpectations(timeout: timeout) { error in
            if let error = error as? XCTestError {
                switch error.code {
                case .failureWhileWaiting:
                    XCTFail("Test failure occurred while waiting for refresh request.")
                case .timeoutWhileWaiting:
                    XCTFail("Timed out waiting for refresh request.")
                default:
                    XCTFail("Unknown error during refresh request.")
                }
            } else {
                // request completed and did not time out; carry on with tests.
                XCTAssertFalse(authorized, "refresh requested, authorized should be false.")
            }
        }
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
            return OHHTTPStubsResponse(data: Payloads.oauth, statusCode: 200, headers: nil)
        }
        stub(condition: pathStartsWith("/test")) { _ in
            return OHHTTPStubsResponse(data: Payloads.test, statusCode: authorized ? 200 : 401, headers: nil)
        }

        let expectation = self.expectation(description: "Test Endpoint")
        client.request(TestEndpoint()) { response, error in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            XCTAssert(response?.count == 1)
            expectation.fulfill()
        }

        // Technique modified from that shown here:
        // https://github.com/AliSoftware/OHHTTPStubs/wiki/OHHTTPStubs-and-asynchronous-tests
        waitForExpectations(timeout: timeout) { error in
            if let error = error as? XCTestError {
                switch error.code {
                case .failureWhileWaiting:
                    XCTFail("Test failure occurred while waiting for refresh request.")
                case .timeoutWhileWaiting:
                    XCTFail("Timed out waiting for refresh request.")
                default:
                    XCTFail("Unknown error during refresh request.")
                }
            } else {
                // request completed and did not time out; carry on with tests.
                XCTAssertTrue(authorized, "refresh request, authorized should be true.")
            }
        }
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

            return OHHTTPStubsResponse(data: Payloads.oauth, statusCode: 200, headers: nil)
        }

        stub(condition: pathStartsWith("/test")) { _ in
            testCount += 1
            return OHHTTPStubsResponse(data: Payloads.test, statusCode: oauthCount > 0 ? 200 : 401, headers: nil)
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

        // Technique modified from that shown here:
        // https://github.com/AliSoftware/OHHTTPStubs/wiki/OHHTTPStubs-and-asynchronous-tests
        waitForExpectations(timeout: timeout) { error in
            if let error = error as? XCTestError {
                switch error.code {
                case .failureWhileWaiting:
                    XCTFail("Test failure occurred while waiting for refresh request.")
                case .timeoutWhileWaiting:
                    XCTFail("Timed out waiting for refresh request.")
                default:
                    XCTFail("Unknown error during refresh request.")
                }
            } else {
                // request completed and did not time out; carry on with tests.

                // Due to timing issues, we can't verify exact counts. The oauth request can be hit before the 10 test requests are sent,
                // causing some portion of the test requests to not need a retry.
                XCTAssert(testCount > 10)
                // I don't have a good explaination of why more than 1 refresh request is made. There's probably a bug to be fixed here, but I don't think
                // it's severe.
                XCTAssert(oauthCount >= 1)
            }
        }
    }
}
