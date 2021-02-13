//
//  EpisodeDetailViewModel.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

class EpisodeDetailViewModel: DetailViewModel {
    let episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    func getDetail1Text() -> String {
        return "TITLE: \(episode.title)"
    }
    
    func getDetail2Text() -> String {
        return "SEASON: \(episode.season), EPISODE \(episode.episode)"
    }
    
    func getDetail3Text() -> String {
        return "AIR DATE: \(episode.air_date)"
    }
    
    func getDetail4Text() -> String {
        return ""
    }
    
    func getDetail5Text() -> String {
        return ""
    }
    
    func getImageUrlString() -> String {
        return ""
    }
    
    
}
