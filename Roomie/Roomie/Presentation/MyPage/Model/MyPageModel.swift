//
//  MyPageModel.swift
//  Roomie
//
//  Created by 예삐 on 1/17/25.
//

import Foundation

struct MyPageModel {
    let title: String
    let subtitle: String?
}

extension MyPageModel {
    static func myPagePlusData() -> [MyPageModel] {
        return [
            MyPageModel(title: "찜 리스트", subtitle: nil),
            MyPageModel(title: "쉐어하우스 찾기", subtitle: "원하는 매물이 없다면 새로 요청해보세요"),
            MyPageModel(title: "매물 등록하기", subtitle: "쉐어하우스 사장님이라면 매물을 등록해보세요"),
            MyPageModel(title: "의견 보내기", subtitle: nil)
        ]
    }
    
    static func myPageServiceData() -> [MyPageModel] {
        return [
            MyPageModel(title: "서비스 소개", subtitle: nil),
            MyPageModel(title: "최근 소식", subtitle: nil),
            MyPageModel(title: "약관 및 정책", subtitle: nil)
        ]
    }
}
