//
//  EpisodeManager.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

protocol EpisodesManager {
    func fetchEpisodes(completion: @escaping ([Episode]) -> ())
}
