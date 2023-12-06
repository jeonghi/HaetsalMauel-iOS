//
//  ParamsConvertible.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

public protocol ParamsConvertible: Codable {
    func toParams() -> [String: Any]
}

public extension ParamsConvertible where Self: Codable {
    func toParams() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let params = jsonObject as? [String: Any] else { return [:] }
            return params
        } catch {
            print("Error converting object to parameters: \(error)")
            return [:]
        }
    }
}
