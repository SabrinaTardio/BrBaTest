//
//  QuoteDetailViewModel.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

struct QuoteDetailViewModel: DetailViewModel {
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
