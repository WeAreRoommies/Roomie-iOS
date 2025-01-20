//
//  BaseResponseBody.swift
//  Roomie
//
//  Created by 예삐 on 1/21/25.
//

struct BaseResponseBody<T: ResponseModelType>: Codable {
    let code: Int
    let message: String
    let data: T?
}
