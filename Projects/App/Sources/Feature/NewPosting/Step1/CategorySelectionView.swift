//
//  CategorySelectionView.swift
//  App
//
//  Created by JH Park on 2023/10/03.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI

struct CategorySelectionView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 0){
      VStack(alignment: .leading){
        Text("마음을 어떻게 비추실 건가요?")
        Rectangle()
          .foregroundColor(Color.gray)
          .frame(width: 328, height: 328)
          .padding(.top, 20)
      }
      
      VStack(alignment: .leading){
        Text("거래 유형")
        HStack {
          Button(action:{}){
            Text("도움 요청")
          }
          Button(action:{}){
            Text("도움 제공")
          }
        }
      }.padding(.top, 40)
      
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct CategorySelectionView_Previews: PreviewProvider {
  static var previews: some View {
    CategorySelectionView()
  }
}
