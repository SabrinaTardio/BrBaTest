//
//  EpisodesListViewModel.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

class EpisodesListViewModel: ListViewModel {
    
    weak var delegateView: ViewModelDelegateView?
    let episodesManager: EpisodesManager
    weak var delegateCoordinator: ListViewModelDelegateCoordinator?
    var episodes: [Episode] = []
    
    init(episodesManager: EpisodesManager, coordinator: ListViewModelDelegateCoordinator) {
        self.episodesManager = episodesManager
        self.delegateCoordinator = coordinator
        updateEpisodes()
    }
    
    func getTitle() -> String {
        return "Episodes"
    }
    
    func getNumberOfRows() -> Int {
        return episodes.count
    }
    
    func getLabelTextFor(_ index: Int) -> String {
        return "Season \(episodes[index].season) Episode \(episodes[index].episode)"
    }
    
    func didSelectRow(_ index: Int) {
        delegateCoordinator?.showDetailViewControllerWith(episodes[index])
    }
    
    private func updateEpisodes() {
        self.episodesManager.fetchEpisodes(completion: { (episodes) in
            self.episodes = episodes
            self.delegateView?.updateUI()
        })
    }
    
    
}
