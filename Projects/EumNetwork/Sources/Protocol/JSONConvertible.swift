//
//  JSONConvertible.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

public protocol JSONConvertible: Encodable {
    func toJSONData() throws -> Data
    static func fromJSONData(_ data: Data) throws -> Self
}

public extension JSONConvertible where Self: Codable {
    func toJSONData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    static func fromJSONData(_ data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }
}

