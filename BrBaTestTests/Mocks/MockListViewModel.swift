//
//  MockListViewModel.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 12/02/2021.
//

import Foundation
@testable import BrBaTest

class MockListViewModel: ListViewModel {
    var delegate: ListViewModelDelegate?
    
    var stringList: [String]
    let title: String
    var selectedRaw: Int?
    
    init(stringList: [String] = [], title: String = "") {
        self.stringList = stringList
        self.title = title
    }
    
    func getNumberOfRows() -> Int {
        return stringList.count
    }
    
    func getLabelTextFor(_ index: Int) -> String {
        return stringList[index]
    }
    
    func didSelectRow(_ index: Int) {
        self.selectedRaw = index
    }
    
    func getTitle() -> String {
        return title
    }
    
}
