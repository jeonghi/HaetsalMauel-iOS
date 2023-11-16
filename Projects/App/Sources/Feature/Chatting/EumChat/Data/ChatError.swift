//
//  ChatError.swift
//  App
//
//  Created by 쩡화니 on 11/12/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

enum ChatError: Error {
    case unknown(source: Error?)
}
