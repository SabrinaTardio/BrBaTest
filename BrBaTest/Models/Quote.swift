//
//  Quote.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

struct Quote: Equatable, Codable {
    let quote_id: Int
    let quote: String
    let author: String
}
