//
//  Networking.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

protocol Networking{
    func get(_ url: URL, completion: @escaping (NetworkingResult) -> ())
}

typealias NetworkingResult = Result<Data, Error>
