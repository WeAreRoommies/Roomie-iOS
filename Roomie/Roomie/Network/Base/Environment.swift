//
//  Environment.swift
//  Roomie
//
//  Created by 예삐 on 1/21/25.
//

import Foundation

enum Environment {
    static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as! String
}
