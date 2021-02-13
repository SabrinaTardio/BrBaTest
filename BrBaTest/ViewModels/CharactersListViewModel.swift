//
//  CharactersListViewModel.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

class CharactersListViewModel: ListViewModel {
    
    weak var delegateView: ViewModelDelegateView?
    let charactersManager: CharactersManager
    weak var delegateCoordinator: ListViewModelDelegateCoordinator?
    var characters: [Character] = []
    
    init(charactersManager: CharactersManager = BrBaCharactersManager(), coordinator: ListViewModelDelegateCoordinator) {
        self.charactersManager = charactersManager
        self.delegateCoordinator = coordinator
        updateCharacters()
    }
    
    func getTitle() -> String {
        return "Characters"
    }
    
    func getNumberOfRows() -> Int {
        return characters.count
    }
    
    func getLabelTextFor(_ index: Int) -> String {
        return characters[index].name
    }
    
    func didSelectRow(_ index: Int) {
        delegateCoordinator?.showDetailViewControllerWith(characters[index])
    }
    
    private func updateCharacters() {
        self.charactersManager.fetchCharacters { (characters) in
            self.characters = characters
            self.delegateView?.updateUI()
        }
    }
    
    
}
