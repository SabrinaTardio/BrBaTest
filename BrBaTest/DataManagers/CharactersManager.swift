//
//  CharactersManager.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

protocol CharactersManager {
    func fetchCharacters(completion: @escaping ([Character]) -> ())
}


class BrBaCharactersManager: CharactersManager{
    func fetchCharacters(completion: @escaping ([Character]) -> ()) {
        
    }
}
