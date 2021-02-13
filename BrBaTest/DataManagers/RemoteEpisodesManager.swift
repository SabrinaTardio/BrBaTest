//
//  RemoteEpisodesManager.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

class RemoteEpisodesManager: EpisodesManager {
    let networking: Networking
    let url: URL
    let decoder: Decoder
    
    init(networking: Networking, url: URL = URL(string: "https://www.breakingbadapi.com/api/episodes")!, decoder: Decoder = DecoderJson()) {
        self.networking = networking
        self.url = url
        self.decoder = decoder
    }
    
    func fetchEpisodes(completion: @escaping ([Episode]) -> ()) {
        networking.get(url) { (result) in
            switch result {
            case .success(let data):
                completion(self.decoder.decode(data: data))
            case .failure(_):
                completion([Episode]())
            }
        }
    }
    
}
