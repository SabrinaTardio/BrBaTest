//
//  ListViewModel.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 12/02/2021.
//

import Foundation

protocol ListViewModel: class {
    var delegateView: ListViewModelDelegateView? {get set}
    var delegateCoordinator: ListViewModelDelegateCoordinator? {get set}
    
    func getTitle() -> String
    func getNumberOfRows() -> Int
    func getLabelTextFor(_ index: Int) -> String
    func didSelectRow(_ index: Int)
}


protocol ListViewModelDelegateView: class {
    func updateUI()
}

protocol ListViewModelDelegateCoordinator: class {
    func showDetailViewControllerWith<T>(_ object: T)
}
