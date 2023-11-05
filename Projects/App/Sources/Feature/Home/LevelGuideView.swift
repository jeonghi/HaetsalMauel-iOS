//
//  LevelGuideView.swift
//  App
//
//  Created by JH Park on 2023/11/01.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import DesignSystemFoundation
import UISystem

struct LevelGuildView: View {
  var body: some View {
    VStack(alignment: .center, spacing: 0){
      title
      subtitle
        .padding(.top, 16)
      levelGuideImage
        .padding(.top, 10)
      levelGuideDesc
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
  }
}

extension LevelGuildView {
  private var title: some View {
    Text("햇살 지수란?")
      .font(.largeTitleB)
      .foregroundColor(Color(.black))
  }
  private var subtitle: some View {
    Text("마을에서 햇살을 모아 나의\n햇님 캐릭터를 성장시킬 수 있어요")
      .font(.subR)
      .foregroundColor(Color(.gray07))
      .multilineTextAlignment(.center)
  }
  private var levelGuideImage: some View {
    VStack(spacing:0){
      ImageAsset.levelGuide.toImage()
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
    }
  }
  
  private var levelGuideDesc: some View {
    VStack(spacing: 10){
      containerBox("먹구름", "누적 교환 햇살 0~30", .cloud)
      containerBox("아기햇님", "누적 교환 햇살 31~100", .babySun)
      containerBox("수호햇님", "누적 교환 햇살 101~", .sun)
    }
  }
  private func containerBox(_ title: String, _ subTitle: String, _ image: ImageAsset) -> some View {
    HStack {
      VStack(alignment: .leading, spacing: 10){
        Text(title)
          .font(.titleB)
        Text(subTitle)
          .font(.subR)
          .foregroundColor(Color(.gray07))
      }
      Spacer()
      image.toImage().resizable()
        .aspectRatio(contentMode: .fit)
        
    }.frame(maxWidth: .infinity)
  }
}

struct LevelGuildView_Previews: PreviewProvider {
  static var previews: some View {
    LevelGuildView()
  }
}
