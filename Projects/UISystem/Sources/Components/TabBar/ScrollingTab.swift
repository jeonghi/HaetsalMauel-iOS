//
//  ScrollingTab.swift
//  UISystem
//
//  Created by 쩡화니 on 11/20/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import Foundation

public struct ScrollingTab<T>: View where T: RawRepresentable, T.RawValue == String, T: Equatable, T: Hashable {
  // MARK: Internal State
  
  
  // MARK: Required Properties
  
  /// Binding the selection index which will  re-render the consuming view
  @Binding var selection: T?
  
  /// The title of the tabs
  let tabs: [T]
  
  // Mark: View Customization Properties
  let font: Font
  let animation: Animation

  let activeTintColor: Color
  let activeTabStrokeColor: Color
  let activeTabBackgroundColor: Color
  let activeOpacity: CGFloat
  
  let inactiveTintColor: Color
  let inactiveTabStrokeColor: Color
  let inactiveTabBackgroundColor: Color
  let inactiveOpacity: CGFloat
  
  let tapSpacing: CGFloat
  let radius: CGFloat
  
  let horizontalPadding: CGFloat
  let verticalPaddingg: CGFloat
  
  let enableScrolling: Bool
  // MARK: init
  
  public init(selection:Binding<T?>, tabs: [T], font: Font = .subR, animation: Animation = .spring(), activeTintColor: Color = Color(.primary), activeTabStrokeColor: Color = Color(.primary), activeTabBackgroundColor: Color = Color(.primaryLight), activeOpacity: CGFloat = 1.0, inactiveTintColor: Color = Color(.systemgray07), inactiveTabStrokeColor: Color = Color.clear, inactiveTabBackgroundColor: Color = Color(.systemgray02), inactiveOpacity: CGFloat = 1.0, tapSpacing: CGFloat = 8, radius: CGFloat = 12, horizontalPadding: CGFloat = 10, verticalPaddingg: CGFloat = 6, enableScrolling: Bool = false) {
    self._selection = selection
    self.tabs = tabs
    self.font = font
    self.animation = animation
    self.activeTintColor = activeTintColor
    self.activeTabStrokeColor = activeTabStrokeColor
    self.activeTabBackgroundColor = activeTabBackgroundColor
    self.activeOpacity = activeOpacity
    self.inactiveTintColor = inactiveTintColor
    self.inactiveTabStrokeColor = inactiveTabStrokeColor
    self.inactiveTabBackgroundColor = inactiveTabBackgroundColor
    self.inactiveOpacity = inactiveOpacity
    self.tapSpacing = tapSpacing
    self.radius = radius
    self.horizontalPadding = horizontalPadding
    self.verticalPaddingg = verticalPaddingg
    self.enableScrolling = enableScrolling
  }
  
  // MARK: View Construction
  
  public var body: some View {
    Group {
      if self.enableScrolling {
        scrollView
      }else {
        staticView
      }
    }
    .padding(.vertical, 2)
  }
  
  private var staticView: some View {
    HStack(spacing: self.tapSpacing) {
      ForEach(self.tabs, id:\.self) {
        self.tab($0)
      }
      Spacer()
    }
  }
  
  private var scrollView: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      ScrollViewReader { reader in
        HStack(spacing: self.tapSpacing) {
          ForEach(self.tabs, id:\.self) {
            self.tab($0)
          }
        }
        .onChange(of: self.selection){ _ in
          reader.scrollTo(selection)
        }
      }
    }
  }
  
  private func tab(_ tab: T) -> some View {
    
    return Button(action: {
      let selection = self.selection == tab ? nil : tab
      withAnimation {
        self.selection = selection
      }
    }) {
      Text(tab.rawValue)
        .font(self.font)
        .foregroundColor(
          self.isSelected(tabIdentifier: tab) ? self.activeTintColor : self.inactiveTintColor
        )
        .padding(.vertical, self.verticalPaddingg)
        .padding(.horizontal, self.horizontalPadding)
        .background(
          RoundedRectangle(cornerRadius: radius, style: .continuous)
            .fill(
              self.isSelected(tabIdentifier: tab) ? self.activeTabBackgroundColor : self.inactiveTabBackgroundColor
            )
            .overlay (
              RoundedRectangle(cornerRadius: radius)
                .stroke(
                  self.isSelected(tabIdentifier: tab) ? self.activeTabStrokeColor : self.inactiveTabStrokeColor ,
                  lineWidth: 1
                )
            )
        )
    }
  }
  
  // MARK: Private Helper
  
  private func isSelected(tabIdentifier: T) -> Bool {
    return selection == tabIdentifier
  }
}

@available(iOS 13.0, *)
struct ScrollingTabConsumerView : View {
  
  @State private var selectedTab: Tab? = Tab.햇살줄래요
  
  enum Tab: String, CaseIterable {
    case 햇살줄래요
    case 햇살받을래요
  }
  var body: some View {
    VStack(alignment: .leading) {
      ScrollingTab(selection: self.$selectedTab,
                   tabs: Tab.allCases)
      
      Button(action:{selectedTab = Tab.allCases[0]}){
        Text("처음으로")
      }
    }
    .padding(.top, 50)
  }
}

#Preview {
  return ScrollingTabConsumerView()
    .padding(.horizontal, 10)
}
