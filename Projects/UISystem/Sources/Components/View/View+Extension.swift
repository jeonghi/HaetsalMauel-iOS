//
//  View+Extension.swift
//  UISystem
//
//  Created by JH Park on 2023/09/30.
//  Copyright © 2023 com.eum. All rights reserved.
//
import SwiftUI

public extension View {
  /// 수평 정렬: leading
  func hLeading() -> some View {
    self.frame(maxWidth: .infinity, alignment: .leading)
  }
  
  /// 수평 정렬: trailing
  func hTrailing() -> some View {
    self.frame(maxWidth: .infinity, alignment: .trailing)
  }
  
  /// 수평 정렬: center
  func hCenter() -> some View {
    self.frame(maxWidth: .infinity, alignment: .center)
  }
  
  /// 수직 정렬: top
  func vTop() -> some View {
    self.frame(maxHeight: .infinity, alignment: .top)
  }
  
  /// 수직 정렬: bottom
  func vBottom() -> some View {
    self.frame(maxHeight: .infinity, alignment: .bottom)
  }
  
  /// 수직 정렬: center
  func vCenter() -> some View {
    self.frame(maxHeight: .infinity, alignment: .center)
  }
}

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
