//
//  URLSessionNetworking.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

class URLSessionNetworking: Networking {
    func get(_ url: URL, completion: @escaping (NetworkingResult) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 || httpResponse.statusCode == 304,
                  error == nil else {
                completion(.failure(NSError()))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            completion(.success(data))
            
        }
        task.resume()
    }
}
