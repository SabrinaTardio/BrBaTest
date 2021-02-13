//
//  CharactersManagerTests.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import XCTest
@testable import BrBaTest

class CharactersManagerTests: XCTestCase {

    let expectedURLString = "https://someUrl\(Date().timeIntervalSince1970)"
    var expectedURL: URL!
    var mockNetworking: CapturingNetworkingClient!
    var charactersManager: CharactersManager!
    
    override func setUp() {
        expectedURL = URL(string: expectedURLString)!
        mockNetworking = CapturingNetworkingClient()
        charactersManager = RemoteCharactersManager(networking: mockNetworking, url: expectedURL)
    }
    
    func testWhenFruitFetched_URLRequestWithCorrectURL() {
        charactersManager.fetchCharacters() { _ in }
        
        XCTAssertEqual(expectedURLString, mockNetworking.capturedURLString)
    }
    
    func testWhenCharactersFetched_CharactersIsGivenBack() {
        let jsonString = "[{\"char_id\":1, \"name\":\"Walter White\", \"birthday\":\"09-07-1958\", \"occupation\":[\"High School Chemistry Teacher\",\"Meth King Pin\"], \"img\":\"someimg\",\"status\":\"Presumed dead\",\"nickname\":\"Heisenberg\",\"appearance\":[1,2,3,4,5],\"portrayed\":\"Bryan Cranston\",\"category\":\"Breaking Bad\",\"better_call_saul_appearance\":[]}, {\"char_id\":2,\"name\":\"Jesse Pinkman\",\"birthday\":\"09-24-1984\",\"occupation\":[\"Meth Dealer\"],\"img\":\"some\",\"status\":\"Alive\",\"nickname\":\"Cap n' Cook\",\"appearance\":[1,2,3,4,5],\"portrayed\":\"Aaron Paul\",\"category\":\"Breaking Bad\",\"better_call_saul_appearance\":[]}]"
        let jsonData = jsonString.data(using: .utf8)!
        let expectedCharacters = [Character(name: "Walter White", occupation: ["High School Chemistry Teacher", "Meth King Pin"], birthday: "09-07-1958", status: "Presumed dead", portrayed: "Bryan Cranston", img: "someimg"), Character(name: "Jesse Pinkman", occupation: ["Meth Dealer"], birthday: "09-24-1984", status: "Alive", portrayed: "Aaron Paul", img: "some")]
        var actualCharacters: [Character] = []
        
        mockNetworking = CapturingNetworkingClient(response: NetworkingResult.success(jsonData))
        charactersManager = RemoteCharactersManager(networking: mockNetworking, url: expectedURL)
        charactersManager.fetchCharacters { (characters) in
            actualCharacters = characters
        }
        XCTWaiter().wait(for: [XCTestExpectation()], timeout: 3)
        
        XCTAssertEqual(expectedCharacters, actualCharacters)
    }
    
    func testWhenNetworkRequestFails_ReturnsEmptyCharactersArray() {
        let expectedCharacters: [Character] = []
        mockNetworking = CapturingNetworkingClient(response: .failure(NSError()))
        charactersManager = RemoteCharactersManager(networking: mockNetworking, url: expectedURL)
        var actualCharacters: [Character]?

        charactersManager.fetchCharacters { (characters) in
            actualCharacters = characters
        }
        
        XCTAssertEqual(expectedCharacters, actualCharacters)
    }
    
    func testWhenParsingFails_ReturnsEmptyCharactersArray() {
        let jsonString = "{some invalid json}"
        let jsonData = jsonString.data(using: .utf8)!
        let expectedCharacters: [Character] = []
        var actualCharacters: [Character]?

        mockNetworking = CapturingNetworkingClient(response: .success(jsonData))
        charactersManager = RemoteCharactersManager(networking: mockNetworking, url: expectedURL)
        charactersManager.fetchCharacters { (characters) in
            actualCharacters = characters
        }
        
        XCTAssertEqual(expectedCharacters, actualCharacters)
    }
}











