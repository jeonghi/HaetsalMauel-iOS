//
//  Button.swift
//  UISystem
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import DesignSystemFoundation
import SwiftUI

public extension StateButtonStyle {
  public static func primary(_ buttonSize: ButtonSize) -> StateButtonStyle {
    StateButtonStyle(buttonSize: buttonSize)
      .style(
        StateButtonConfigure(fontConfig: .descriptionR, foreground: Color(.primary), background: Color(.secondary)),
        for: .normal
      )
      .style(
        StateButtonConfigure(fontConfig: .descriptionR, foreground: Color(.primary), background: Color(.secondary)),
        for: .pressed
      )
  }
}


struct StateButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
      Button(action:{}){
        IconLabel(leftIcon: .pencil, text: "라벨")
      }
      .buttonStyle(StateButtonStyle.primary(.large))
    }
}
