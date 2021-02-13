//
//  EpisodeDetailViewModelTests.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import XCTest
@testable import BrBaTest

class EpisodeDetailViewModelTests: XCTestCase {

    var episode: Episode!
    var vm: DetailViewModel!
    let title = "some title"
    let season = "season n"
    let episodeNumber = "episode n"
    let airdate = "sometime"

    
    override func setUp() {
        episode  = Episode(season: season, episode: episodeNumber, title: title, air_date: airdate)
        vm = EpisodeDetailViewModel(episode: episode)
    }


    func testReturnsCorrectDetail1() {
        let actualDetail = vm.getDetail1Text()
        XCTAssertEqual("TITLE: \(title)", actualDetail)
    }
    
    func testReturnsCorrectDetail2() {
        let actualDetail = vm.getDetail2Text()
        XCTAssertEqual("SEASON: \(season), EPISODE \(episodeNumber)", actualDetail)
    }
    
    func testReturnsCorrectDetail3() {
        let actualDetail = vm.getDetail3Text()
        XCTAssertEqual("AIR DATE: \(airdate)", actualDetail)
    }
    
    func testReturnsCorrectDetail4() {
        let actualDetail = vm.getDetail4Text()
        XCTAssertEqual("", actualDetail)
    }
    
    func testReturnsCorrectDetail5() {
        let actualDetail = vm.getDetail5Text()
        XCTAssertEqual("", actualDetail)
    }
    
    func testReturnsCorrectImgUrl() {
        let actualUrl = vm.getImageUrlString()
        XCTAssertEqual("", actualUrl)
    }
    
}

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
