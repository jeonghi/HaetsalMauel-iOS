//
//  UserProfile.swift
//  App
//
//  Created by JH Park on 2023/09/29.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI

struct UserProfile: View {
    var body: some View {
      
      VStack {
        
        HStack {
          Text("최소융님 안녕하세요")
          Spacer()
          Button(action:{}){
            Text("내 정보 수정")
          }
        }
        
        Rectangle()
          .foregroundColor(Color.black.opacity(0.2))
          .frame(height: 30)
          .frame(width: 300)
        
        HStack(spacing: 26) {
          
          Circle()
            .foregroundColor(Color.black.opacity(0.3))
            .frame(width: 128, height: 128)
          
          VStack(alignment: .leading){
            Text("아기 햇님")
            Text("최소융")
          }
          
          Spacer()
        }
      }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
