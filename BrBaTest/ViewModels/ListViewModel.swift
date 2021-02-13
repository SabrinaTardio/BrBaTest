//
//  ListViewModel.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 12/02/2021.
//

import Foundation

protocol ListViewModel: class {
    var delegateView: ViewModelDelegateView? {get set}
    var delegateCoordinator: ListViewModelDelegateCoordinator? {get set}
    
    func getTitle() -> String
    func getNumberOfRows() -> Int
    func getLabelTextFor(_ index: Int) -> String
    func didSelectRow(_ index: Int)
}


protocol ViewModelDelegateView: class {
    func updateUI()
}

protocol ListViewModelDelegateCoordinator: class {
    func showDetailViewControllerWith<T>(_ object: T)
}
