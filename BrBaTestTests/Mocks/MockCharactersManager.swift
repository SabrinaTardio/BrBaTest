//
//  MockCharactersManager.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation
@testable import BrBaTest

class MockCharactersManager: CharactersManager {
    var characters: [Character]
    var completion: (([Character]) -> ())?
    
    init(charactersResponse: [Character] = []) {
        self.characters = charactersResponse
    }
    
    func fetchCharacters(completion: @escaping ([Character]) -> ()) {
        self.completion = completion
    }
    
    
    func performCompletion() {
        completion!(characters)
    }
    
}
