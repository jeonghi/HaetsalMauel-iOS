//
//  MakeProfileIntroView.swift
//  App
//
//  Created by JH Park on 2023/10/31.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import UISystem
import DesignSystemFoundation

struct MakeProfileIntroView: View {
  var body: some View {
    VStack(spacing: 0){
      
      welcomeComment
        .vTop()
        .hLeading()
        .padding(.top, 72)
        .padding(.horizontal, 22)
      
      BILogo
        .vCenter()
        .padding(.horizontal, 124)
      
      nextButton
        .vBottom()
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
  }
}

extension MakeProfileIntroView {
  
  private var welcomeComment: some View {
    Text("성공적으로 가입했어요!\n프로필을 완성하러 가볼까요?")
      .multilineTextAlignment(.leading)
  }
  private var BILogo: some View {
    ImageAsset.onboardingLogo.toImage()
      .resizable()
      .aspectRatio(contentMode: .fit)
  }
  
  private var nextButton: some View {
    Button(action: {}){
      Text("프로필 만들기")
    }
    .buttonStyle(PrimaryButtonStyle())
  }
}

struct MakeProfileIntroView_Previews: PreviewProvider {
  static var previews: some View {
    MakeProfileIntroView()
  }
}
