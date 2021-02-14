//
//  ViewModelsFactory.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 14/02/2021.
//

import Foundation

struct ViewModelsFactory: ListViewModelFactory, DetailViewModelFactory {
    let charactersManager: CharactersManager
    let episodesManager: EpisodesManager
    let quotesManager: QuotesManager
    
    init(charactersManager: CharactersManager, episodesManager: EpisodesManager, quotesManager: QuotesManager) {
        self.charactersManager = charactersManager
        self.episodesManager = episodesManager
        self.quotesManager = quotesManager
    }
    
    func makeListViewModel(viewModelType: ViewModelType, coordinator: ListViewModelDelegateCoordinator) -> ListViewModel {
        switch viewModelType {
        case .characters:
            return CharactersListViewModel(charactersManager: charactersManager, coordinator: coordinator)
        case .episodes:
            return EpisodesListViewModel(episodesManager: episodesManager, coordinator: coordinator)
        case .quotes:
        return QuotesListViewModel(quotesManager: quotesManager, coordinator: coordinator)
        }
    }
    
    func makeDetailViewModel<T>(object: T) -> DetailViewModel {
        var detailVM: DetailViewModel
        switch object {
        case is Character:
            detailVM = CharacterDetailViewModel(character: object as! Character)
        case is Episode:
            detailVM = EpisodeDetailViewModel(episode: object as! Episode)
        case is Quote:
            detailVM = QuoteDetailViewModel(quote: object as! Quote)
        default:
            fatalError()
        }
        return detailVM
    }
    
}


protocol ListViewModelFactory {
    func makeListViewModel(viewModelType: ViewModelType, coordinator: ListViewModelDelegateCoordinator)  -> ListViewModel
}

protocol DetailViewModelFactory {
    func makeDetailViewModel<T>(object: T) -> DetailViewModel
}

enum ViewModelType {
    case characters
    case episodes
    case quotes
}
