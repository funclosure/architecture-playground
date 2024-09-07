//
//  ViewModel.swift
//
//
//  Created by Chung Yun Lee on 7/9/2024.
//

import Foundation
import Combine

struct ViewModelInput {
    let query: AnyPublisher<String, Never>
}

struct ViewModelOutput {
    let result: AnyPublisher<String, Never>
    let isLoading: AnyPublisher<Bool, Never>
    let error: AnyPublisher<String?, Never>
}

class ViewModel: ViewModelType {
    private let dataService: DataServiceType
    
    init(dataService: DataServiceType) {
        self.dataService = dataService
    }
    
    func transform(input: ViewModelInput) -> ViewModelOutput {
        let queryWithDebounce = input.query
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
        
        let isLoading = queryWithDebounce
            .map { _ in true }
            .merge(with: queryWithDebounce.flatMap { _ in Just(false).delay(for: .seconds(1), scheduler: RunLoop.main) })
            .eraseToAnyPublisher()
        
        let result = queryWithDebounce
            .flatMap { [dataService] query in
                dataService.fetchData(query: query)
                    .catch { _ in Just("Error occurred") }
            }
            .eraseToAnyPublisher()
        
        let error = queryWithDebounce
            .flatMap { [dataService] query in
                dataService.fetchData(query: query)
                    .map { _ in nil as String? }
                    .catch { Just($0.localizedDescription) }
            }
            .eraseToAnyPublisher()
        
        return ViewModelOutput(result: result, isLoading: isLoading, error: error)
    }
}
