//
//  NewPostLabel.swift
//  UISystem
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import DesignSystemFoundation

public struct NewPostLabel: View {
  public init(){
    
  }
  public var body: some View {
    HStack(spacing: 8) {
      ImageAsset.펜.toImage()
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(height: 24)
      Text("글쓰기")
    }
    .font(.headerB)
    .foregroundColor(Color(.buttonDefaultForeground))
    .padding(.vertical, 14)
    .padding(.horizontal, 16)
    .background(
      RoundedRectangle(cornerRadius: 12, style: .continuous)
        .fill(Color(.buttonDefaultBackground))
        .shadow(color: Color.black.opacity(0.08), radius: 10, y: -5)
    )
  }
}
