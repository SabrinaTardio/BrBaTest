//
//  EpisodsListViewModelTests.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import XCTest
@testable import BrBaTest


class EpisodsListViewModelTests: XCTestCase {

    var episodesManager: MockEpisodesManager!
    var vm: ListViewModel!
    var capturingCoordinator: CapturingCoordinator!
    let episodes = [Episode.fixture(season: "1", episode: "3"), Episode.fixture(season: "2", episode: "1"), Episode.fixture()]
    let updatedCharacters = [Episode.fixture(season: "3", episode: "3"), Episode.fixture()]
    
    override func setUp() {
        episodesManager  = MockEpisodesManager(episodesResponse: episodes)
        capturingCoordinator = CapturingCoordinator()
        vm = EpisodesListViewModel(episodesManager: episodesManager, coordinator: capturingCoordinator)
    }
    
    func testReturnsExpectedTitle() {
        let expectedTitle = "Episodes"
        XCTAssertEqual(expectedTitle, vm.getTitle())
    }

    func testReturnCorrectNumberOfRows() {
        episodesManager.performCompletion()
        let actualNumberOfRows = vm.getNumberOfRows()
        XCTAssertEqual(actualNumberOfRows, episodes.count)
    }

    func testReturnCorrectLabelText() {
        episodesManager.performCompletion()
        let selectedIndex = Int.random(in: 0..<episodes.count)
        let actualLabelText = vm.getLabelTextFor(selectedIndex)
        let expectedLabel = "Season \(episodes[selectedIndex].season) Episode \(episodes[selectedIndex].episode)"
        XCTAssertEqual(actualLabelText, expectedLabel)
    }

    func testOnDidSelectRawAskCoordinatorToChangeScreenWithSelectedEpisode() {
        episodesManager.performCompletion()
        let selectedIndex = Int.random(in: 0..<episodes.count)
        vm.didSelectRow(selectedIndex)

        XCTAssertEqual(capturingCoordinator.selectedEpisode, episodes[selectedIndex])
    }

    func testOnCharactersManagerCallBackWarnsTheDelegateView() {
        let delegate = CaptuiringVMDelegate()
        vm.delegateView = delegate
        episodesManager.performCompletion()
        XCTAssertTrue(delegate.updateUICalled)
    }

    func testDelegateViewIsNotRetained() {
        var delegate: ListViewModelDelegateView? = CaptuiringVMDelegate()
        weak var weakDelegate = delegate
        vm.delegateView = delegate
        delegate = nil

        XCTAssertNil(weakDelegate)
    }

    func testDelegateCoordinatorIsNotRetained() {
        var delegate: ListViewModelDelegateCoordinator? = CapturingCoordinator()
        weak var weakDelegate = delegate
        vm.delegateCoordinator = delegate
        delegate = nil

        XCTAssertNil(weakDelegate)
    }


}


extension Episode {
    static func fixture(season: String = "1", episode: String = "4") -> Episode {
        return Episode(season: season, episode: episode, title: "", air_date: "")
    }
}


