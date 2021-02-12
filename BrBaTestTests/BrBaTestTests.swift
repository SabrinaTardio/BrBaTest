//
//  BrBaTestTests.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 12/02/2021.
//

import XCTest
@testable import BrBaTest

class BrBaTestTests: XCTestCase {

    var vc: ListViewController!
    var vm: MockListViewModel!
    let expectedTitle = "someTitle \(Date().timeIntervalSince1970)"
    var expectedStringArray: [String]!
    
    override func setUp() {
        expectedStringArray = randomStringList()
        vm = MockListViewModel(stringList: expectedStringArray, title: expectedTitle)
        vc = ListViewControllersFactory().makeListViewController(fruitListViewModel: vm) as? ListViewController
        vc.viewModel = vm
        vc.displayOnScreen()
    }

    override func tearDown() {
        vc = nil
        vm = nil
    }
    
    func testTableViewHasOneSection() {
        let expectedSectionCount = 1
        let actualSectionCount = vc.listTableView.numberOfSections
        XCTAssertEqual(expectedSectionCount, actualSectionCount)
    }
    
    func testHasExpectedTitle() {
        let actualTitle = vc.titleLabel.text
        
        XCTAssertEqual(expectedTitle, actualTitle)
    }
    
    
    
    private func randomStringList() -> [String] {
        var array: [String] = []
        for i in 0...Int.random(in: 0...100) {
            array.append("\(i) \(Date().timeIntervalSince1970)")
        }
        return array
    }

}

extension UIViewController {
    func displayOnScreen() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
        window.rootViewController = self
    }
}




class MockListViewModel: ListViewModel {
    let stringList: [String]
    let title: String
    
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
        
    }
    
    func getTitle() -> String {
        return title
    }
    

}






