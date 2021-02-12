//
//  ListViewModel.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 12/02/2021.
//

import Foundation

protocol ListViewModel {
    func getTitle() -> String
    func getNumberOfRows() -> Int
    func getLabelTextFor(_ index: Int) -> String
    func didSelectRow(_ index: Int)
}
