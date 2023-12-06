//
//  View+NavigationBackButton.swift
//  App
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import UISystem
import DesignSystemFoundation

extension View {
  func setCustomNavBackButton() -> some View {
    modifier(CustomBackButtonModifier())
  }
  func setCustomNavBarTitle(_ title: String) -> some View {
    modifier(CustomNavTitleModifier(title: title))
  }
  
  func setCustomNavCloseButton() -> some View {
    modifier(CustomCloseButtonModifier())
  }
  
  func navigate<Content: View>(if condition: Binding<Bool>, to content: Content) -> some View {
    NavigationView {
      ZStack {
        self
        NavigationLink("", destination: content, isActive: condition)
      }
    }
  }
}

struct CustomBackButtonModifier: ViewModifier {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  func body(content: Content) -> some View {
    content
      .navigationBarBackButtonHidden(true)
      .highPriorityGesture(
        DragGesture().onEnded({ value in
          if value.translation.width > 70 { // 스와이프 거리 조정
            self.presentationMode.wrappedValue.dismiss()
          }
        })
      )
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarLeading){
          Button(action: {self.presentationMode.wrappedValue.dismiss()}){
            ImageAsset.뒤로가기.toImage()
              .renderingMode(.template)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .foregroundColor(Color(.black))
              .frame(height: 22)
          }
        }
      }
  }
}

struct CustomCloseButtonModifier: ViewModifier {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  func body(content: Content) -> some View {
    content
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarLeading){
          Button(action: {self.presentationMode.wrappedValue.dismiss()}){
            ImageAsset.닫기.toImage()
              .renderingMode(.template)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .foregroundColor(Color(.black))
              .frame(height: 22)
          }
        }
      }
  }
}

struct CustomNavTitleModifier: ViewModifier {
  let title: String
  func body(content: Content) -> some View {
    content
      .navigationBarHidden(false)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItemGroup(placement: .principal){
          Text(title)
            .foregroundColor(Color(.black))
            .font(.headerB)
        }
      }
  }
}

#Preview {
  NavigationView {
    List {
      Text("Sample Code")
    }
    .setCustomNavBackButton()
    .setCustomNavBarTitle("테스트")
  }
}
