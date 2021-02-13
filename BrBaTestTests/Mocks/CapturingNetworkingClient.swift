//
//  CapturingNetworkingClient.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation
@testable import BrBaTest

class CapturingNetworkingClient: Networking {
    var capturedURLString: String = ""
    let response: Result<Data, Error>
    var completion: ((NetworkingResult) -> ())?
    
    init(response: NetworkingResult = NetworkingResult.success(Data())) {
        self.response = response
    }
    
    func get(_ url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        self.capturedURLString = url.absoluteString
        completion(response)
    }
}
