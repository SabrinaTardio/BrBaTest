//
//  Decoder.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

protocol Decoder {
    func decode<T: Codable>(data: Data) -> [T]
}

class DecoderJson: Decoder {
    func decode<T: Codable>(data: Data) -> [T] {
        let decoder = JSONDecoder()
        var objects = [T]()
        do {
            objects = try decoder.decode([T].self, from: data)
        } catch {
            print("parsingError: \(error)")
        }
        return objects
    }
}
