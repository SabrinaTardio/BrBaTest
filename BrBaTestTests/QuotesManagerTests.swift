//
//  QuotesManagerTests.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import XCTest
@testable import BrBaTest

class QuotesManagerTests: XCTestCase {

    let expectedURLString = "https://someUrl\(Date().timeIntervalSince1970)"
    var expectedURL: URL!
    var mockNetworking: CapturingNetworkingClient!
    var quotesManager: QuotesManager!
    
    override func setUp() {
        expectedURL = URL(string: expectedURLString)!
        mockNetworking = CapturingNetworkingClient()
        quotesManager = RemoteQuotesManager(networking: mockNetworking, url: expectedURL)
    }
    
    func testWhenFruitFetched_URLRequestWithCorrectURL() {
        quotesManager.fetchQuotes() { _ in }
        
        XCTAssertEqual(expectedURLString, mockNetworking.capturedURLString)
    }
    
    func testWhenQuotesFetched_QuotesIsGivenBack() {
        let jsonString = "[{\"quote_id\":1,\"quote\":\"I am not in danger, Skyler. I am the danger!\",\"author\":\"Walter White\",\"series\":\"Breaking Bad\"},{\"quote_id\":2,\"quote\":\"Stay out of my territory.\",\"author\":\"Walter White\",\"series\":\"Breaking Bad\"}]"
        let jsonData = jsonString.data(using: .utf8)!
        let expectedQuotes = [Quote(quote_id: 1, quote: "I am not in danger, Skyler. I am the danger!", author: "Walter White"), Quote(quote_id: 2, quote: "Stay out of my territory.", author: "Walter White")]
        var actualQuotes: [Quote] = []
        
        mockNetworking = CapturingNetworkingClient(response: NetworkingResult.success(jsonData))
        quotesManager = RemoteQuotesManager(networking: mockNetworking, url: expectedURL)
        quotesManager.fetchQuotes { (quotes) in
            actualQuotes = quotes
        }
        
        XCTAssertEqual(expectedQuotes, actualQuotes)
    }

    func testWhenNetworkRequestFails_ReturnsEmptyCharactersArray() {
        let expectedQuotes: [Quote] = []
        mockNetworking = CapturingNetworkingClient(response: .failure(NSError()))
        quotesManager = RemoteQuotesManager(networking: mockNetworking, url: expectedURL)
        var actualQuotes: [Quote]?
        quotesManager.fetchQuotes { (quotes) in
            actualQuotes = quotes
        }
        
        XCTAssertEqual(expectedQuotes, actualQuotes)
    }

    func testWhenParsingFails_ReturnsEmptyCharactersArray() {
        let jsonString = "{some invalid json}"
        let jsonData = jsonString.data(using: .utf8)!
        var actualQuotes: [Quote]?
        let expectedQuotes: [Quote] = []

        mockNetworking = CapturingNetworkingClient(response: .success(jsonData))
        quotesManager = RemoteQuotesManager(networking: mockNetworking, url: expectedURL)
        quotesManager.fetchQuotes { (quotes) in
            actualQuotes = quotes
        }

        XCTAssertEqual(expectedQuotes, actualQuotes)
    }
}


class RemoteQuotesManager: QuotesManager {
    let networking: Networking
    let url: URL
    
    init(networking: Networking, url: URL = URL(string: "https://www.breakingbadapi.com/api/quotes")!) {
        self.networking = networking
        self.url = url
    }
    
    func fetchQuotes(completion: @escaping ([Quote]) -> ()) {
        networking.get(url) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeToQuotes(data: data))
            case .failure(_):
                completion([Quote]())
            }
        }
    }
    
    private func decodeToQuotes(data: Data) -> [Quote] {
        let decoder = JSONDecoder()
        var quotes = [Quote]()
        do {
            quotes = try decoder.decode([Quote].self, from: data)
        } catch {
            print("parsingError: \(error)")
        }
        return quotes
    }
}
