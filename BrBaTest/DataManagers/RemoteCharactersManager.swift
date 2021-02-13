//
//  RemoteCharactersManager.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

class RemoteCharactersManager: CharactersManager {
    let networking: Networking
    let url: URL
    
    init(networking: Networking, url: URL = URL(string: "https://www.breakingbadapi.com/api/characters")!) {
        self.networking = networking
        self.url = url
    }
    
    func fetchCharacters(completion: @escaping ([Character]) -> ()) {
        networking.get(url) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeToCharacters(data: data))
            case .failure(_):
                completion([Character]())
            }
        }
    }
    
    private func decodeToCharacters(data: Data) -> [Character] {
        let decoder = JSONDecoder()
        var characters = [Character]()
        do {
            characters = try decoder.decode([Character].self, from: data)
        } catch {
            print("parsingError: \(error)")
        }
        return characters
    }
}
