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
    let decoder: Decoder
    
    init(networking: Networking, url: URL = URL(string: "https://www.breakingbadapi.com/api/quotes")!, decoder: Decoder = DecoderJson()) {
        self.networking = networking
        self.url = url
        self.decoder = decoder
    }
    
    func fetchQuotes(completion: @escaping ([Quote]) -> ()) {
        networking.get(url) { (result) in
            switch result {
            case .success(let data):
                completion(self.decoder.decode(data: data))
            case .failure(_):
                completion([Quote]())
            }
        }
    }
}
