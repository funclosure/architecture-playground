//
//  ViewController+SwiftUI.swift
//
//
//  Created by Chung Yun Lee on 7/9/2024.
//

import Foundation
import SwiftUI

struct UIKitViewControllerWrapper: UIViewControllerRepresentable {
    let viewModel: ViewModel
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Updates can be handled here if needed
    }
}
