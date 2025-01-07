//
//  Observable.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import Foundation

class ObservablePattern<T> {
    var value: T? {
        didSet {
            self.listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
