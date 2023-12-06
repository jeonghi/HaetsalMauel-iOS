//
//  MoyaError+Extension.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/26/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import Moya

extension MoyaError {
    var responseStatusCode: Int? {
        switch self {
        case .underlying(let nsError as NSError, _):
            return nsError.code
        case .statusCode(let response):
            return response.statusCode
        default:
            return nil
        }
    }

    var responseBody: Data? {
        return self.response?.data
    }

    var responseJSON: Any? {
        guard let data = responseBody else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: [])
    }

    var isInvalidTokenError: Bool {
        guard case .underlying(let error, _) = self,
              let urlError = error as? URLError,
              urlError.code == .userAuthenticationRequired else {
            return false
        }
        return true
    }
  
    var isNotFoundError: Bool {
        guard case .statusCode(let response) = self,
              response.statusCode == 404 else {
            return false
        }
        return true
    }

    var serverErrorMessage: String? {
        return (try? self.response?.map(ErrorMessage.self).message) ?? nil
    }
}

struct ErrorMessage: Decodable {
    let message: String
}
