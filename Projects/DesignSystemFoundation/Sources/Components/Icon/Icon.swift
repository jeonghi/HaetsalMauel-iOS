//
//  Icon.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/24.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//
import Foundation
import SwiftUI

public struct Icon: View {
  @Environment(\.iconTint) public var iconTint: Color
  @Environment(\.iconSize) public var iconSize: IconSize
  @Environment(\.renderingMode) public var renderingMode: Image.TemplateRenderingMode // orginal or template
  
  public var image: Image
  public var tintColor: Color?
  
  public init(image: Image, tintColor: Color? = nil) {
    self.image = image
    self.tintColor = tintColor
  }
  
  public var body: some View {
    image
      .renderingMode(renderingMode)
      .resizable()
      .foregroundColor(tintColor ?? iconTint)
      .frame(width: iconSize.width, height: iconSize.height)
  }
}
