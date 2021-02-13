//
//  QuoteDetailViewModel.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import XCTest
@testable import BrBaTest

class QuoteDetailViewModelTests: XCTestCase {

    var quote: Quote!
    var vm: DetailViewModel!
    let id = 5
    let quoteString = "some quote"
    let author = "somebody"

    
    override func setUp() {
        quote  = Quote(quote_id: id, quote: quoteString, author: author)
        vm = QuoteDetailViewModel(quote: quote)
    }


    func testReturnsCorrectDetail1() {
        let actualDetail = vm.getDetail1Text()
        XCTAssertEqual(quoteString, actualDetail)
    }
    
    func testReturnsCorrectDetail2() {
        let actualDetail = vm.getDetail2Text()
        XCTAssertEqual(author, actualDetail)
    }
    
    func testReturnsCorrectDetail3() {
        let actualDetail = vm.getDetail3Text()
        XCTAssertEqual("", actualDetail)
    }
    
    func testReturnsCorrectDetail4() {
        let actualDetail = vm.getDetail4Text()
        XCTAssertEqual("", actualDetail)
    }
    
    func testReturnsCorrectDetail5() {
        let actualDetail = vm.getDetail5Text()
        XCTAssertEqual("", actualDetail)
    }
    
    func testReturnsCorrectImgUrl() {
        let actualUrl = vm.getImageUrlString()
        XCTAssertEqual("", actualUrl)
    }
    
}

class QuoteDetailViewModel: DetailViewModel {
    let quote: Quote
    
    init(quote: Quote) {
        self.quote = quote
    }
    
    func getDetail1Text() -> String {
        return quote.quote
    }
    
    func getDetail2Text() -> String {
        return quote.author
    }
    
    func getDetail3Text() -> String {
        return ""
    }
    
    func getDetail4Text() -> String {
        return ""
    }
    
    func getDetail5Text() -> String {
        return ""
    }
    
    func getImageUrlString() -> String {
        return ""
    }
    
    
}
