//
//  ActionSheet+Extension.swift
//  App
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import UISystem
import DesignSystemFoundation

extension ActionSheet.Button {
    static func defaultButton(title: String, font: Font = .headerB, action: @escaping () -> Void) -> ActionSheet.Button {
      .default(Text(title).font(font).foregroundColor(Color(.black)), action: action)
    }

    static func destructiveButton(title: String, font: Font = .headerB, action: @escaping () -> Void) -> ActionSheet.Button {
      .destructive(Text(title).font(font).foregroundColor(Color(.black)), action: action)
    }

    static func cancelButton(title: String = "취소", font: Font = .headerB) -> ActionSheet.Button {
        .cancel(Text(title).font(font))
    }
}
