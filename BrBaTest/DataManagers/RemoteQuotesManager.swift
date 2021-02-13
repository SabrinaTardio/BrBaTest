//
//  RemoteQuotesManager.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

class RemoteQuotesManager: QuotesManager {
    let networking: Networking
    let url: URL
    
    init(networking: Networking, url: URL = URL(string: "https://www.breakingbadapi.com/api/quotes")!) {
        self.networking = networking
        self.url = url
    }
    
    func fetchQuotes(completion: @escaping ([Quote]) -> ()) {
        networking.get(url) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeToQuotes(data: data))
            case .failure(_):
                completion([Quote]())
            }
        }
    }
    
    private func decodeToQuotes(data: Data) -> [Quote] {
        let decoder = JSONDecoder()
        var quotes = [Quote]()
        do {
            quotes = try decoder.decode([Quote].self, from: data)
        } catch {
            print("parsingError: \(error)")
        }
        return quotes
    }
}
