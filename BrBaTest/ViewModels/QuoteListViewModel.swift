//
//  QuoteListViewModel.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation


class QuotesListViewModel: ListViewModel {
    
    weak var delegateView: ListViewModelDelegateView?
    let quotesManager: QuotesManager
    weak var delegateCoordinator: ListViewModelDelegateCoordinator?
    var quotes: [Quote] = []
    
    init(quotesManager: QuotesManager, coordinator: ListViewModelDelegateCoordinator) {
        self.quotesManager = quotesManager
        self.delegateCoordinator = coordinator
        updateQuotes()
    }
    
    func getTitle() -> String {
        return "Quotes"
    }
    
    func getNumberOfRows() -> Int {
        return quotes.count
    }
    
    func getLabelTextFor(_ index: Int) -> String {
        return "Quote \(quotes[index].quote_id)"
    }
    
    func didSelectRow(_ index: Int) {
        delegateCoordinator?.showDetailViewControllerWith(quotes[index])
    }
    
    private func updateQuotes() {
        self.quotesManager.fetchQuotes { (quotes) in
            self.quotes = quotes
            self.delegateView?.updateUI()
        }
    }
    
    
}
