//
//  String+.swift
//  Roomie
//
//  Created by 예삐 on 1/15/25.
//

import Foundation

extension String {
    static func formattedDate(date: Date, format: String = "yyyy/MM/dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
