//
//  CancelBag.swift
//  Roomie
//
//  Created by 예삐 on 1/10/25.
//

import Combine

final class CancelBag {
    fileprivate var subscriptions = Set<AnyCancellable>()
    
    deinit {
        cancel()
    }
    
    func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
