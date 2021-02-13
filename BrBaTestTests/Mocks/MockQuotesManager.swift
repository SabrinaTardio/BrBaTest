//
//  MockQuotesManager.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation
@testable import BrBaTest

class MockQuotesManager: QuotesManager {
    var quotes: [Quote]
    var completion: (([Quote]) -> ())?
    
    init(quotesResponse: [Quote] = []) {
        self.quotes = quotesResponse
    }
    
    func fetchQuotes(completion: @escaping ([Quote]) -> ()) {
        self.completion = completion
    }
    
    
    func performCompletion() {
        completion!(quotes)
    }
    
}
