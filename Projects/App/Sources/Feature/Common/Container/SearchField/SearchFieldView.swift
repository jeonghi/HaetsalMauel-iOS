//
//  SearchFieldView.swift
//  App
//
//  Created by 쩡화니 on 11/28/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation
import UISystem
import Foundation

struct SearchFieldView: View {
  @Binding var searchText: String
  let searchButtonAction: (()->Void)?
  var body: some View {
    검색창
      .padding(8)
      .background(
        RoundedRectangle(cornerRadius: 10)
          .fill(Color(.systemgray02))
      )
      .frame(maxWidth: .infinity)
      .padding(1)
  }
}

extension SearchFieldView {
  private var 검색창: some View {
    HStack(spacing: 6) {
      검색아이콘
      텍스트필드
    }
  }
  
  private var 검색아이콘: some View {
      ImageAsset.검색.toImage()
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(height: 24)
        .foregroundColor(Color(.systemgray07))
  }
  
  private var 지우기버튼: some View {
    Button(action: {searchText = ""}){
      ImageAsset.닫기.toImage()
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(height: 24)
        .foregroundColor(Color(.systemgray05))
    }
  }
  
  private var 텍스트필드: some View {
    ZStack {
      TextField(text: $searchText, prompt: nil){
        Text("검색어를 입력하세요")
          .font(.subR)
          .foregroundColor(Color(.systemgray07))
      }
      .textFieldStyle(.plain)
      .autocapitalization(.none) // 자동 대문자 사용 안함
      .disableAutocorrection(true) // 자동 수정 비활성화
      .onSubmit {
          // 검색 실행 로직
          searchButtonAction?()
      }
      
      if !searchText.isEmpty {
        지우기버튼
          .hTrailing()
      }
    }
  }
}

#Preview {
  VStack {
    SearchFieldView(searchText: .constant("333"), searchButtonAction: {})
    SearchFieldView(searchText: .constant(""), searchButtonAction: {})
  }
}
