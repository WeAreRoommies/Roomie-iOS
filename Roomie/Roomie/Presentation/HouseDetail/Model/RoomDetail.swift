//
//  RoomDetail.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import Foundation

struct RoomDetail {
    let roomID: Int
    let name: String
    let facility: [String]
    let status: Bool
    let mainImgURL: String
}

extension RoomDetail {
    static func mockData() -> [RoomDetail] {
        return [
            RoomDetail(
                roomID: 1,
                name: "룸A",
                facility: ["책상", "침대", "옷장"],
                status: true,
                mainImgURL: "https://example.com/room1.jpg"
            ),
            RoomDetail(
                roomID: 2,
                name: "룸B",
                facility: ["책상", "침대", "옷장", "옷장", "옷장"],
                status: false,
                mainImgURL: "https://example.com/room1.jpg"
            ),
            RoomDetail(
                roomID: 3,
                name: "룸C",
                facility: ["책상", "침대", "옷장", "옷장", "옷장", "책상", "책상", "책상"],
                status: true,
                mainImgURL: "https://example.com/room1.jpg"
            )
        ]
    }
}
