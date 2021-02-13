//
//  EpisodesManagerTests.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import XCTest
@testable import BrBaTest

class EpisodesManagerTests: XCTestCase {

    let expectedURLString = "https://someUrl\(Date().timeIntervalSince1970)"
    var expectedURL: URL!
    var mockNetworking: CapturingNetworkingClient!
    var episodesManager: EpisodesManager!
    
    override func setUp() {
        expectedURL = URL(string: expectedURLString)!
        mockNetworking = CapturingNetworkingClient()
        episodesManager = RemoteEpisodesManager(networking: mockNetworking, url: expectedURL)
    }
    
    func testWhenFruitFetched_URLRequestWithCorrectURL() {
        episodesManager.fetchEpisodes() { _ in }
        
        XCTAssertEqual(expectedURLString, mockNetworking.capturedURLString)
    }
    
    func testWhenEpisodesFetched_EpisodesIsGivenBack() {
        let jsonString = "[{\"episode_id\":1,\"title\":\"Pilot\",\"season\":\"1\",\"air_date\":\"01-20-2008\",\"characters\":[\"Walter White\",\"Jesse Pinkman\",\"Skyler White\",\"Hank Schrader\",\"Marie Schrader\",\"Walter White Jr.\",\"Krazy-8\",\"Bogdan Wolynetz\"],\"episode\":\"1\",\"series\":\"Breaking Bad\"},{\"episode_id\":2,\"title\":\"Cat's in the Bag...\",\"season\":\"1\",\"air_date\":\"01-27-2008\",\"characters\":[\"Walter White\",\"Jesse Pinkman\",\"Skyler White\",\"Walter White Jr.\",\"Krazy-8\"],\"episode\":\"2\",\"series\":\"Breaking Bad\"}]"
        let jsonData = jsonString.data(using: .utf8)!
        let expectedEpisodes = [Episode(season: "1", episode: "1", title: "Pilot", air_date: "01-20-2008"), Episode(season: "1", episode: "2", title: "Cat's in the Bag...", air_date: "01-27-2008")]
        var actualEpisodes: [Episode] = []
        
        mockNetworking = CapturingNetworkingClient(response: NetworkingResult.success(jsonData))
        episodesManager = RemoteEpisodesManager(networking: mockNetworking, url: expectedURL)
        episodesManager.fetchEpisodes { (episodes) in
            actualEpisodes = episodes
        }
        
        XCTAssertEqual(expectedEpisodes, actualEpisodes)
    }
    
    func testWhenNetworkRequestFails_ReturnsEmptyEpisodesArray() {
        let expectedEpisodes: [Episode] = []
        mockNetworking = CapturingNetworkingClient(response: .failure(NSError()))
        episodesManager = RemoteEpisodesManager(networking: mockNetworking, url: expectedURL)
        var actualEpisodes: [Episode]?
        episodesManager.fetchEpisodes { (episodes) in
            actualEpisodes = episodes
        }
        
        XCTAssertEqual(expectedEpisodes, actualEpisodes)    }
    
    func testWhenParsingFails_ReturnsEmptyEpisodesArray() {
        let jsonString = "{some invalid json}"
        let jsonData = jsonString.data(using: .utf8)!
        var actualEpisodes: [Episode]?
        let expectedEpisodes: [Episode] = []

        mockNetworking = CapturingNetworkingClient(response: .success(jsonData))
        episodesManager = RemoteEpisodesManager(networking: mockNetworking, url: expectedURL)
        episodesManager.fetchEpisodes { (episodes) in
            actualEpisodes = episodes
        }

        XCTAssertEqual(expectedEpisodes, actualEpisodes)
    }
}



