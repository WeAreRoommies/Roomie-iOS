//
//  WebViewType.swift
//  Roomie
//
//  Created by 예삐 on 7/18/25.
//

enum WebViewType {
    case searchHouse
    case registerHouse
    case sendFeedback
    case introduceService
    case latestNews
    case policy
    
    var url: String {
        switch self {
        case .searchHouse:
            return "https://tally.so/r/3y8ygX"
        case .registerHouse:
            return "https://pf.kakao.com/_WviTn"
        case .sendFeedback:
            return "https://tally.so/r/megeRl"
        case .introduceService:
            return "https://automatic-protocol-11a.notion.site/23336a29f06280a394ceea5f51b2d09b?source=copy_link"
        case .latestNews:
            return "https://automatic-protocol-11a.notion.site/23336a29f06280e4b956f3dc6bf963bc?source=copy_link"
        case .policy:
            return "https://automatic-protocol-11a.notion.site/23336a29f06280d5a4f0c622c73a5121?source=copy_link"
        }
    }
}
