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
  @Environment(\.iconTint) var iconTint: Color
  @Environment(\.iconSize) var iconSize: IconSize
  @Environment(\.renderingMode) var renderingMode: Image.TemplateRenderingMode // orginal or template
  
  public var image: Image
  public var tintColor: Color?
  
  public init(image: Image, tintColor: Color?) {
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
