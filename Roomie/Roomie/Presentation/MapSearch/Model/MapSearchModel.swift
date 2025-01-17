//
//  MapSearchModel.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import Foundation

struct MapSearchModel: Hashable {
    let location: String
    let address: String
    let roadAddress: String
}

extension MapSearchModel {
    static func mockMapSearchData() -> [MapSearchModel] {
        return [
            MapSearchModel(
                location: "이화여자대학교",
                address: "서울특별시 서대문구 대현동 11-1",
                roadAddress: "서울특별시 서대문구 이화여대길 52"
            ),
            MapSearchModel(
                location: "루미하우스",
                address: "서울특별시 서대문구 대현동 11-1",
                roadAddress: "서울특별시 서대문구 이화여대길 52"
            ),
            MapSearchModel(
                location: "건국대학교",
                address: "서울특별시 서대문구 대현동 11-1",
                roadAddress: "서울특별시 서대문구 이화여대길 52"
            ),
            MapSearchModel(
                location: "성신여자대학교",
                address: "서울특별시 서대문구 대현동 11-1",
                roadAddress: "서울특별시 서대문구 이화여대길 52"
            ),
            MapSearchModel(
                location: "서울여자대학교",
                address: "서울특별시 서대문구 대현동 11-1",
                roadAddress: "서울특별시 서대문구 이화여대길 52"
            )
        ]
    }
}
