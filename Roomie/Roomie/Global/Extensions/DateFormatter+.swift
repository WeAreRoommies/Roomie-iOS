//
//  DateFormatter+.swift
//  Roomie
//
//  Created by 예삐 on 7/4/25.
//

import Foundation

extension DateFormatter {
    
    static let inputSlash: DateFormatter = {
        let formmater = DateFormatter()
        formmater.locale = Locale(identifier: "en_US_POSIX")
        formmater.dateFormat = "yyyy/MM/dd"
        return formmater
    }()
    
    static let outputHyphen: DateFormatter = {
        let formmater = DateFormatter()
        formmater.locale = Locale(identifier: "en_US_POSIX")
        formmater.dateFormat = "yyyy-MM-dd"
        return formmater
    }()
}
