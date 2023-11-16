//
//  SlidingTab.swift
//  UISystem
//
//  Created by JH Park on 2023/10/02.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI

public struct SlidingTab<T>: View where T: RawRepresentable, T.RawValue == String, T: Equatable, T: Hashable {
  
  // MARK: Required Properties
  
  /// Binding the selection index which will  re-render the consuming view
  @Binding var selection: T
  
  /// The title of the tabs
  let tabs: [T]
  
  // Mark: View Customization Properties
  
  /// The font of the tab title
  let font: Font
  
  /// The selection bar sliding animation type
  let animation: Animation
  
  /// The accent color when the tab is selected
  let activeAccentColor: Color
  
  /// The accent color when the tab is not selected
  let inactiveAccentColor: Color
  
  /// The color of the selection bar
  let selectionBarColor: Color
  
  /// The tab color when the tab is not selected
  let inactiveTabColor: Color
  
  /// The tab color when the tab is  selected
  let activeTabColor: Color
  
  /// The height of the selection bar
  let selectionBarHeight: CGFloat
  
  /// The selection bar background color
  let selectionBarBackgroundColor: Color
  
  /// The height of the selection bar background
  let selectionBarBackgroundHeight: CGFloat
  
  let scrolling: Bool
  
  let backgroundColor: Color
  
  // MARK: init
  
  public init(selection: Binding<T>,
              tabs: [T],
              font: Font = .headerB,
              animation: Animation = .spring(),
              activeAccentColor: Color = Color(.black),
              inactiveAccentColor: Color = Color.black.opacity(0.4),
              selectionBarColor: Color = Color(.black),
              inactiveTabColor: Color = .clear,
              activeTabColor: Color = .clear,
              selectionBarHeight: CGFloat = 2,
              selectionBarBackgroundColor: Color = Color(.systemgray07),
              selectionBarBackgroundHeight: CGFloat = 2,
              scrolling: Bool = false,
              backgroundColor: Color = .white
  ) {
    self._selection = selection
    self.tabs = tabs
    self.font = font
    self.animation = animation
    self.activeAccentColor = activeAccentColor
    self.inactiveAccentColor = inactiveAccentColor
    self.selectionBarColor = selectionBarColor
    self.inactiveTabColor = inactiveTabColor
    self.activeTabColor = activeTabColor
    self.selectionBarHeight = selectionBarHeight
    self.selectionBarBackgroundColor = selectionBarBackgroundColor
    self.selectionBarBackgroundHeight = selectionBarBackgroundHeight
    self.scrolling = scrolling
    self.backgroundColor = backgroundColor
  }
  
  // MARK: View Construction
  
  public var body: some View {
    
    return Group {
      if(scrolling){
        ScrollView(.horizontal, showsIndicators: false){
          content
        }
      }else{
        content
      }
    }
  }
  
  private var content: some View {
    return VStack(alignment: .leading, spacing: 0) {
      HStack(spacing: 0) {
        ForEach(self.tabs, id:\.self) { tab in
          Button(action: {
            self.selection = tab
          }) {
            HStack {
              Spacer()
              Text(tab.rawValue)
                .font(self.font)
              Spacer()
            }
          }
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .accentColor(
            self.isSelected(tabIdentifier: tab)
            ? self.activeAccentColor
            : self.inactiveAccentColor)
          .background(
            self.isSelected(tabIdentifier: tab)
            ? self.activeTabColor
            : self.inactiveTabColor)
        }
      }
      .background(backgroundColor)
      GeometryReader { geometry in
        ZStack(alignment: .leading) {
          Rectangle()
            .fill(self.selectionBarBackgroundColor)
            .frame(width: geometry.size.width, height: self.selectionBarBackgroundHeight, alignment: .leading)
            .cornerRadius(2, corners: .allCorners)
          Rectangle()
            .fill(self.selectionBarColor)
            .frame(width: self.tabWidth(from: geometry.size.width), height: self.selectionBarHeight, alignment: .leading)
            .cornerRadius(2, corners: .allCorners)
            .offset(x: self.selectionBarXOffset(from: geometry.size.width), y: 0)
            .animation(self.animation)
        }.fixedSize(horizontal: false, vertical: true)
      }.fixedSize(horizontal: false, vertical: true)
      
    }
  }
  
  // MARK: Private Helper
  
  private func isSelected(tabIdentifier: T) -> Bool {
    return selection == tabIdentifier
  }
  
  private func selectionBarXOffset(from totalWidth: CGFloat) -> CGFloat {
    return self.tabWidth(from: totalWidth) * CGFloat(self.tabs.firstIndex(of: selection) ?? 0)
  }
  
  private func tabWidth(from totalWidth: CGFloat) -> CGFloat {
    return totalWidth / CGFloat(tabs.count)
  }
}

@available(iOS 13.0, *)
struct SlidingTabConsumerView : View {
  
  enum Tab: String, CaseIterable {
    case all = "전체"
    case activity = "활동"
  }
  
  @State private var selectedTab = Tab.all
  
  var body: some View {
    VStack(alignment: .leading) {
      SlidingTab<Tab>(selection: self.$selectedTab,
                      tabs: Tab.allCases
                    )
      switch selectedTab {
      default:
        Text(
          selectedTab.rawValue
        )
      }
      Spacer()
    }
    .padding(.top, 50)
    .animation(.none)
  }
}

struct SlidingTab_Previews: PreviewProvider {
  static var previews: some View {
    SlidingTabConsumerView()
      .padding(.horizontal, 10)
  }
}
