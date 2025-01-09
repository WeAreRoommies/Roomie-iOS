//
//  ViewModelType.swift
//  Roomie
//
//  Created by 예삐 on 1/10/25.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output
}
