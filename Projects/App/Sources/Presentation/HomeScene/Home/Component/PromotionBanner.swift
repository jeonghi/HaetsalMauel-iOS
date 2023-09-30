//
//  PromotionBanner.swift
//  App
//
//  Created by JH Park on 2023/09/29.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct PromotionBanner: View {
  
  @StateObject var currPage: Page = .withIndex(0)
  
  var body: some View {
    Pager(
      page: currPage,
      data: ["광고 배너1","광고 배너2","광고 배너3","광고 배너4"],
      id: \.self
    ) {
      self.pageView($0)
        .frame(width: .infinity)
    }
    .loopPages(repeating: 0)
    .draggingAnimation(.none)
    .horizontal()
    .alignment(.start)   
  }
  
  func pageView(_ data: String) -> some View{
    ZStack {
      Color.gray
      Text(data)
        .foregroundColor(Color.white)
    }
    .frame(width: UIScreen.main.bounds.width)
  }
}

struct PromotionBanner_Previews: PreviewProvider {
  static var previews: some View {
    PromotionBanner()
  }
}
