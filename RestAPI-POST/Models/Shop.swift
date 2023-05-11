//
//  Shop.swift
//  RestAPI-POST
//
//  Created by 渡邊魁優 on 2023/05/11.
//

import Foundation

struct Shop: Decodable {
    let id: String
    let name: String
    let longitude: Double
    let latitude: Double
}
