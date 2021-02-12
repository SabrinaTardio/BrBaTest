//
//  ListViewModel.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 12/02/2021.
//

import Foundation

protocol ListViewModel: class {
    var delegate: ListViewModelDelegate? {get set}
    
    func getTitle() -> String
    func getNumberOfRows() -> Int
    func getLabelTextFor(_ index: Int) -> String
    func didSelectRow(_ index: Int)
}


protocol ListViewModelDelegate: class {
    func updateUI()
}
