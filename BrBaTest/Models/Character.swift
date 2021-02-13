//
//  Character.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

struct Character:Codable, Equatable {
    let name: String
    let occupation: [String]
    let birthday: String
    let status: String
    let portrayed: String
    let img: String
}
