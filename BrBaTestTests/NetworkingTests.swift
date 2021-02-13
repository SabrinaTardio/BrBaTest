//
//  NetworkingTests.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import XCTest
import GCDWebServer
@testable import BrBaTest


class NetworkingTests: XCTestCase {

    var webServer: GCDWebServer!
    var expectedData = "success \(Date().timeIntervalSince1970)".data(using: .utf8)!
    var dataResponse: GCDWebServerResponse!
    var non200or404Response: GCDWebServerResponse!
    var networking: Networking!
    
    override func setUp() {
        dataResponse = GCDWebServerDataResponse(data: self.expectedData, contentType: "text/plain")
        non200or404Response = GCDWebServerResponse(statusCode: Int.random(in: 305...600))
    }

    override func tearDown() {
        webServer?.stop()
    }
    
    func testCanGetNetworkResponse() {
        let expectation = XCTestExpectation(description: "can get network request expectation")
        setUpWebServer(with: dataResponse)
        
        var actualData = Data()
        
        networking = URLSessionNetworking()
        networking.get(webServer.serverURL!) { (result) in
            actualData = try! result.get()
            expectation.fulfill()
        }
        
        XCTWaiter().wait(for:  [expectation], timeout: 5)
        XCTAssertEqual(actualData, expectedData)
    }
    
    func testReturnsFailureOnNone200or304Response() {
        let networkingClient = URLSessionNetworking()
        let requestExpectation = XCTestExpectation(description: "request timed out")
        self.setUpWebServer(with: non200or404Response)

        var actualResult: NetworkingResult!
        networkingClient.get(URL(string: "http://localhost:\(webServer.port)")!) { result in
            actualResult = result
            requestExpectation.fulfill()
        }
        XCTWaiter().wait(for: [requestExpectation], timeout: 2)
    
        XCTAssertTrue(actualResult?.isFailure() ?? false, "actual Result was success")
    }
    
    func testReturnsFailureOnCantConnectToServer() {
        let networkingClient = URLSessionNetworking()
        let requestExpectation = XCTestExpectation(description: "request timed out")

        var actualResult: NetworkingResult!
        networkingClient.get(URL(string: "http://localhost:4059/doesntexist\(Date().timeIntervalSince1970)")!) { result in
            actualResult = result
            requestExpectation.fulfill()
        }
        XCTWaiter().wait(for: [requestExpectation], timeout: 2)
    
        XCTAssertTrue(actualResult?.isFailure() ?? false, "actual Result was success")
    }
    
    private func setUpWebServer(with response: GCDWebServerResponse) {
        webServer = GCDWebServer()
        webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self) { (request) -> GCDWebServerResponse? in
            return response
        }
        webServer.start()
    }
    
    
}


extension Result {
    func isFailure() -> Bool {
        guard let _ = try? self.get() else { return true }
        return false
    }
}


