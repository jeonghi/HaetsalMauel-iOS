//
//  DashBoardLabel.swift
//  UISystem
//
//  Created by JH Park on 2023/09/29.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation

public struct DashBoardLabel: View {
  
  var icon: Icon?
  var title: String
  var subtitle: String?
  
  @Environment(\.dashBoardLabelStyle) var style
  
  public init(icon: Icon? = nil, title: String, subtitle: String?) {
    self.icon = icon
    self.title = title
    self.subtitle = subtitle
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      icon?
      //              .iconStyle(IconStyle(iconSize: style.iconStyle.iconSize, tintColor: style.iconStyle.tintColor, opacity: style.iconStyle.opacity))
        .padding(.bottom ,5)
      
      Text(title)
        .font(style.titleStyle.font)
        .foregroundColor(style.titleStyle.color)
        .padding(.bottom, 5)
      
      Text(subtitle ?? "")
        .font(style.subTitleStyle.font)
        .foregroundColor(style.subTitleStyle.color)
    }
  }
}

struct DashBoardLabel_Previews: PreviewProvider {
  static var previews: some View {
    DashBoardLabel(icon: .pencil, title: "잔여 햇살", subtitle: "20")
      .dashBoardLabelStyle(.homeDashBoard)
  }
}
