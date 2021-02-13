//
//  QuoteManager.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

protocol QuotesManager {
    func fetchQuotes(completion: @escaping ([Quote]) -> ())
}
