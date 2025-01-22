//
//  String+.swift
//  Roomie
//
//  Created by 예삐 on 1/15/25.
//

import Foundation

extension String {
    
    /// Date를 "yyyy/MM/dd" 타입의 String으로 변환
    static func formattedDate(date: Date, format: String = "yyyy/MM/dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /// "yyyy/MM/dd" 타입의 String을 Date 타입의 String으로 변환
    static func formattedDateString(
        _ dateString: String,
        inputFormat: String = "yyyy/MM/dd",
        outputFormat: String = "yyyy-MM-dd"
    ) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        formatter.dateFormat = inputFormat
        guard let date = formatter.date(from: dateString) else { return nil }
        
        formatter.dateFormat = outputFormat
        return formatter.string(from: date)
    }
    
    /// Int 타입을 받아 "123,456,789원" 형식의 String 값으로 변환
    static func formattedWonString(from value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        if let formattedValue = formatter.string(from: NSNumber(value: value)) {
            return "\(formattedValue)원"
        }
        return "\(value)원"
    }
}
