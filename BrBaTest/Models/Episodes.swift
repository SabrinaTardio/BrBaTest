//
//  Episodes.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

struct Episode: Equatable, Codable {
    let season: String
    let episode: String
    let title: String
    let air_date: String
}
