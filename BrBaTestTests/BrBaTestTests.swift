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
    
    func testListShowsCorrectText() {
        let numberOfStrings = expectedStringArray.count
        let raw = Int.random(in: 0..<numberOfStrings)
        let tableView = vc.listTableView
        let cell = tableView?.cellForRow(at: IndexPath(row: raw, section: 0))
        let cellString = cell?.textLabel?.text
        
        XCTAssertEqual(cellString, expectedStringArray[raw])
    }
    
    func testWhenElementSelectedCallsDidSelectRow() {
        let numberOfStrings = expectedStringArray.count
        let expectedSelectedRaw = Int.random(in: 0..<numberOfStrings)
        let tableView = vc.listTableView!
        vc.tableView(tableView, didSelectRowAt: IndexPath(row: expectedSelectedRaw, section: 0))

        XCTAssertEqual(vm.selectedRaw, expectedSelectedRaw)
    }
    
    func testCanUpdateTableView() {
        let updatedStringList = randomStringList()
        vm.stringList = updatedStringList
        vm.delegate?.updateUI()
        XCTWaiter().wait(for: [XCTestExpectation()], timeout: 2)

        let tableView = vc.listTableView
        let tableViewCellNumber = tableView?.numberOfRows(inSection: 0)
        let randomRaw = Int.random(in: 0..<updatedStringList.count)
        let cell = tableView?.cellForRow(at: IndexPath(row: randomRaw, section: 0))
        let cellString = cell?.textLabel?.text
        XCTAssertEqual(tableViewCellNumber, updatedStringList.count)
        XCTAssertEqual(cellString, updatedStringList[randomRaw])
    }
    
    
    
    private func randomStringList() -> [String] {
        var array: [String] = []
        for i in 0...Int.random(in: 0...10) {
            array.append("\(i) \(Date().timeIntervalSince1970)")
        }
        return array
    }

}

extension UIViewController {
    func displayOnScreen() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
        window.rootViewController = self
        XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
    }
}




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



