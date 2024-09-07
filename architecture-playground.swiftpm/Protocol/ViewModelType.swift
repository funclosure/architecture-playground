//
//  ViewModelType.swift
//  
//
//  Created by Chung Yun Lee on 7/9/2024.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
