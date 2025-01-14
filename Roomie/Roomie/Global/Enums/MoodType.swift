//
//  MoodType.swift
//  Roomie
//
//  Created by MaengKim on 1/14/25.
//
enum MoodType {
    case calm
    case lively
    case neat
    
    var title: String {
        switch self {
        case .calm:
            return "# 차분한"
        case .lively:
            return "# 활기찬"
        case .neat:
            return "# 깔끔한"
        }
    }
    
    var subTitle: String {
        switch self {
        case.calm:
            return "차분한 분위기의\n방이 궁금하신가요?"
        case .lively:
            return "활기찬 분위기의\n방이 궁금하신가요?"
        case .neat:
            return "깔끔한 분위기의\n방이 궁금하신가요?"
        }
    }
}
