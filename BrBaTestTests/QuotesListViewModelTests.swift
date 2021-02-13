//
//  QuotesListViewModel.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import XCTest
@testable import BrBaTest

class QuotesListViewModelTests: XCTestCase {

    var quotesManager: MockQuotesManager!
    var vm: ListViewModel!
    var capturingCoordinator: CapturingCoordinator!
    let quotes = [Quote.fixture(id: 1), Quote.fixture(id: 78), Quote.fixture()]
    let updatedQuotes = [Quote.fixture(id: 54), Quote.fixture()]
    
    override func setUp() {
        quotesManager  = MockQuotesManager(quotesResponse: quotes)
        capturingCoordinator = CapturingCoordinator()
        vm = QuotesListViewModel(quotesManager: quotesManager, coordinator: capturingCoordinator)
    }
    
    func testReturnsExpectedTitle() {
        let expectedTitle = "Quotes"
        XCTAssertEqual(expectedTitle, vm.getTitle())
    }

    func testReturnCorrectNumberOfRows() {
        quotesManager.performCompletion()
        let actualNumberOfRows = vm.getNumberOfRows()
        XCTAssertEqual(actualNumberOfRows, quotes.count)
    }

    func testReturnCorrectLabelText() {
        quotesManager.performCompletion()
        let selectedIndex = Int.random(in: 0..<quotes.count)
        let actualLabelText = vm.getLabelTextFor(selectedIndex)
        let expectedLabel = "Quote \(quotes[selectedIndex].id)"
        XCTAssertEqual(actualLabelText, expectedLabel)
    }

    func testOnDidSelectRawAskCoordinatorToChangeScreenWithSelectedEpisode() {
        quotesManager.performCompletion()
        let selectedIndex = Int.random(in: 0..<quotes.count)
        vm.didSelectRow(selectedIndex)

        XCTAssertEqual(capturingCoordinator.selectedQuote, quotes[selectedIndex])
    }

    func testOnCharactersManagerCallBackWarnsTheDelegateView() {
        let delegate = CaptuiringVMDelegate()
        vm.delegateView = delegate
        quotesManager.performCompletion()
        XCTAssertTrue(delegate.updateUICalled)
    }

    func testDelegateViewIsNotRetained() {
        var delegate: ListViewModelDelegateView? = CaptuiringVMDelegate()
        weak var weakDelegate = delegate
        vm.delegateView = delegate
        delegate = nil

        XCTAssertNil(weakDelegate)
    }

    func testDelegateCoordinatorIsNotRetained() {
        var delegate: ListViewModelDelegateCoordinator? = CapturingCoordinator()
        weak var weakDelegate = delegate
        vm.delegateCoordinator = delegate
        delegate = nil

        XCTAssertNil(weakDelegate)
    }


}



extension Quote {
    static func fixture(id: Int = 1) -> Quote {
        return Quote(id: id)
    }
}



