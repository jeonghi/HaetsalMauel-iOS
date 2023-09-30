//
//  View+Extension.swift
//  UISystem
//
//  Created by JH Park on 2023/09/30.
//  Copyright © 2023 com.eum. All rights reserved.
//
import SwiftUI

public extension View {
  /// 특정 모서리 cornerRadius
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}

private struct RoundedCorner: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    return Path(path.cgPath)
  }
}
