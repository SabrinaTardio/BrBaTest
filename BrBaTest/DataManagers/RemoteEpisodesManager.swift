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
    
    init(networking: Networking, url: URL = URL(string: "https://www.breakingbadapi.com/api/episodes")!) {
        self.networking = networking
        self.url = url
    }
    
    func fetchEpisodes(completion: @escaping ([Episode]) -> ()) {
        networking.get(url) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeToEpisodes(data: data))
            case .failure(_):
                completion([Episode]())
            }
        }
    }
    
    private func decodeToEpisodes(data: Data) -> [Episode] {
        let decoder = JSONDecoder()
        var episodes = [Episode]()
        do {
            episodes = try decoder.decode([Episode].self, from: data)
        } catch {
            print("parsingError: \(error)")
        }
        return episodes
    }
}
