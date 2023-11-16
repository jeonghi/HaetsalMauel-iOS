//
//  CharacterLabel.swift
//  UISystem
//
//  Created by 쩡화니 on 11/12/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import DesignSystemFoundation
import SwiftUI

public struct CharacterLabel: View {
  let type: 캐릭터타입
  
  public init(type: 캐릭터타입) {
    self.type = type
  }
  
  public var body: some View {
    VStack(spacing: 10){
      ZStack {
        switch type {
        case .노인:
          makeImage(.노인)
        case .중장년:
          makeImage(.중장년)
        case .청년:
          makeImage(.청년)
        case .청소년:
          makeImage(.청소년)
        }
      }
      .aspectRatio(130/68, contentMode: .fill)
      .frame(maxWidth: .infinity, alignment: .center)
      
      HStack {
        Text(type.rawValue)
          .font(.subB)
          .foregroundColor(Color(.black))
      }
      .aspectRatio(130/21, contentMode: .fill)
      .frame(maxWidth: .infinity, alignment: .center)
    }
    .padding(.vertical, 20)
    .padding(16)
    .aspectRatio(162/162, contentMode: .fit)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .foregroundColor(Color(.systemgray02))
    )
  }
}

extension CharacterLabel {
  private func makeImage(_ img: ImageAsset) -> some View {
    img.toImage()
      .resizable()
      .aspectRatio(contentMode: .fit)
      .background(Color(.white))
      .clipShape(Circle())
  }
}

public extension CharacterLabel {
  enum 캐릭터타입: String {
    case 노인
    case 중장년
    case 청년
    case 청소년
  }
}

#Preview {
  VStack {
    HStack(spacing: 10) {
      CharacterLabel(type: .노인)
      CharacterLabel(type: .중장년)
    }
    HStack(spacing: 10) {
      CharacterLabel(type: .노인)
      CharacterLabel(type: .중장년)
    }
  }
}
