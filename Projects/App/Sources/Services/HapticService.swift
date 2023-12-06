//
//  HapticService.swift
//  App
//
//  Created by 쩡화니 on 11/29/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import UIKit

protocol HapticServiceType {
  func hapticNotification(type: UINotificationFeedbackGenerator.FeedbackType)
  func hapticImpact(style: UIImpactFeedbackGenerator.FeedbackStyle)
  func hapticSelection()
}

class HapticService: HapticServiceType {
  static let shared = HapticService()
  
  private init(){}
  
  // warning, error, success
  func hapticNotification(type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
  }
  
  // heavy, light, meduium, rigid, soft
  func hapticImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
  }
  
  func hapticSelection() {
    let generator = UISelectionFeedbackGenerator()
    generator.selectionChanged()
  }
}
