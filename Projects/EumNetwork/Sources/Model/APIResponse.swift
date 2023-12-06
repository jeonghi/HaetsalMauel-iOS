//
//  APIResponse.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/26/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    let code: String
    let data: T?
    let detailMsg: String?
    let msg: String
    let status: Int
}
