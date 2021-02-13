//
//  CapturingCoordinator.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation
@testable import BrBaTest

class CapturingCoordinator: ListViewModelDelegateCoordinator {
    var selectedCharacter: Character?
    var selectedEpisode: Episode?
    var selectedQuote: Quote?
    
    func showDetailViewControllerWith<T>(_ object: T) {
        selectedCharacter = object as? Character
        selectedEpisode = object as? Episode
        selectedQuote = object as? Quote
    }
}
