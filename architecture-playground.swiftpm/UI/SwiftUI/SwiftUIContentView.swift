//
//  SwiftUIContentView.swift
//
//
//  Created by Chung Yun Lee on 7/9/2024.
//

import SwiftUI
import Combine

// MARK: - ViewState

class ViewState: ObservableObject {
    @Published var query: String = ""
    @Published var result: String = ""
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ViewModel) {
        self.subscribe(to: viewModel)
    }
    
    private func subscribe(to viewModel: ViewModel) {
        let output = viewModel.transform(input: ViewModelInput(query: $query.eraseToAnyPublisher()))
        
        output.result
            .assign(to: \.result, on: self)
            .store(in: &cancellables)
        
        output.isLoading
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
        
        output.error
            .assign(to: \.error, on: self)
            .store(in: &cancellables)
    }
}

// MARK: - View
struct SwiftUIContentView: View {
    @StateObject private var viewState: ViewState
    
    init(viewModel: ViewModel) {
        self._viewState = StateObject(
            wrappedValue: ViewState(viewModel: viewModel)
        )
    }
    
    var body: some View {
        VStack {
            TextField("Enter query", text: $viewState.query)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if viewState.isLoading {
                ProgressView()
            } else if let error = viewState.error {
                Text(error)
                    .foregroundColor(.red)
            }
            Text(viewState.result)
            Spacer(minLength: 0)
        }
    }
}
