//
//  OAuthTests.swift
//  PRODUCTNAME
//
//  Created by Brian King on 11/3/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import OHHTTPStubs
import XCTest
@testable import PRODUCTNAME

class OAuthTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        OHHTTPStubs.setEnabled(true)
    }

    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }

    func testOAuthLogin() {
        stub(condition: isMethodPOST() && pathStartsWith("/oauth/token")) { request in
            return OHHTTPStubsResponse(data: Payloads.oauth, statusCode: 200, headers:nil)
        }
        let configuration = URLSessionConfiguration.default
        OHHTTPStubs.setEnabled(true, for: configuration)
        let oauthClient = OAuthClient(configuration: configuration)

        let expectation = self.expectation(description: "Login Complete")
        oauthClient.login(username: "username", password: "password") { error in
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertTrue(oauthClient.isAuthenticated)
        XCTAssertEqual(oauthClient.credentials?.refreshToken, "FAKE_REFRESH_TOKEN")
        XCTAssertEqual(oauthClient.credentials?.accessToken, "FAKE_TOKEN")
        XCTAssertTrue(oauthClient.credentials?.expirationDate.timeIntervalSinceNow ?? 0 > 0)
    }

    func testOAuthRefresh() {
        stub(condition: pathStartsWith("/oauth/refresh")) { _ in
            return OHHTTPStubsResponse(data: Payloads.oauth, statusCode:200, headers:nil)
        }
        let configuration = URLSessionConfiguration.default
        OHHTTPStubs.setEnabled(true, for: configuration)
        let oauthClient = OAuthClient(configuration: configuration)
        oauthClient.credentials = OAuthClient.Credentials(
            refreshToken: "INITIAL_REFRESH_TOKEN",
            accessToken: "INVALID_TOKEN",
            expirationDate: Date.distantPast
        )
        let expectation = self.expectation(description: "Login Complete")
        oauthClient.refresh() { _ in
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertTrue(oauthClient.isAuthenticated)
        XCTAssertEqual(oauthClient.credentials?.refreshToken, "FAKE_REFRESH_TOKEN")
        XCTAssertEqual(oauthClient.credentials?.accessToken, "FAKE_TOKEN")
        XCTAssertTrue(oauthClient.credentials?.expirationDate.timeIntervalSinceNow ?? 0 > 0)
    }

    func testAdaptBeforeAuthenticated() {
        let oauthClient = OAuthClient()
        let request = URLRequest(url: URL(string: "http://test.com")!)
        do {
            _ = try oauthClient.adapt(request)
            oauthClient.credentials = OAuthClient.Credentials(
                refreshToken: "INITIAL_REFRESH_TOKEN",
                accessToken: "INVALID_TOKEN",
                expirationDate: Date.distantPast
            )
            _ = try oauthClient.adapt(request)
        }
        catch {
            XCTFail("Adapt should not throw")
        }
    }
}
