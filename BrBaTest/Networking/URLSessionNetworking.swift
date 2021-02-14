//
//  URLSessionNetworking.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

struct URLSessionNetworking: Networking {
    func get(_ url: URL, completion: @escaping (NetworkingResult) -> ()) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
