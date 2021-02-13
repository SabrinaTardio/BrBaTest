//
//  MockEpisodesManager.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation
@testable import BrBaTest


class MockEpisodesManager: EpisodesManager {
    var episodes: [Episode]
    var completion: (([Episode]) -> ())?
    
    init(episodesResponse: [Episode] = []) {
        self.episodes = episodesResponse
    }
    
    func fetchEpisodes(completion: @escaping ([Episode]) -> ()) {
        self.completion = completion
    }
    
    
    func performCompletion() {
        completion!(episodes)
    }
    
}
