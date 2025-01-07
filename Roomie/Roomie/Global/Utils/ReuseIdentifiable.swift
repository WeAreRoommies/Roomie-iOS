//
//  ReuseIdentifiable.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String { String(describing: Self.self) }
}
