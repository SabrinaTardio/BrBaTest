//
//  RemoteCharactersManager.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

struct RemoteCharactersManager: CharactersManager {
    let networking: Networking
    let url: URL
    let decoder: Decoder
    
    init(networking: Networking, url: URL = URL(string: "https://www.breakingbadapi.com/api/characters")!, decoder: Decoder = DecoderJson()) {
        self.networking = networking
        self.url = url
        self.decoder = decoder
    }
    
    func fetchCharacters(completion: @escaping ([Character]) -> ()) {
        networking.get(url) {(result) in
            switch result {
            case .success(let data):
                completion(decoder.decode(data: data))
            case .failure(_):
                completion([Character]())
            }
        }
    }
}
