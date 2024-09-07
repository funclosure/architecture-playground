//
//  DataService.swift
//  
//
//  Created by Chung Yun Lee on 7/9/2024.
//

import Foundation
import Combine

protocol DataServiceType {
    func fetchData(query: String) -> AnyPublisher<String, Error>
}

class MockDataService: DataServiceType {
    func fetchData(query: String) -> AnyPublisher<String, Error> {
        Just("Mocked result for query: \(query)")
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
