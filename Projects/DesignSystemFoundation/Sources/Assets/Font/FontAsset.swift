//
//  FontAsset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/24.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import Foundation

public struct FontAsset {
  
  /// FontFamily / Weight / Bundle / 확장자 (ex. otf, ttf...) 등
  var config: FontConfig
  /// 크기
  var size: CGFloat
  /// 행간
  var leading: Leading?
  
  public init(_ config: FontConfig, size: CGFloat, leading: Leading? = nil) {
    self.config = config
    self.size = size
    self.leading = leading
  }
}

extension FontAsset {
  public enum Leading {
    case none
    case small
    case medium
    case large
    case lineHeight(CGFloat)
    
    var value: CGFloat {
      switch self {
      case .none:
        return 0
      case .small:
        return 5.0
      case .medium:
        return 10.0
      case .large:
        return 15.0
      case .lineHeight(let value):
        return value
      }
    }
  }
}

extension FontAsset {
  public struct FontConfig {
    enum Weight: String {
      case regular
      case bold
      case light
      case medium
      // ... other weights
    }
    
    enum FileType: String {
      case otf
      case ttf
      // ... other file types
    }
    
    var fontFamily: String
    var weight: Weight
    var bundle: Bundle? // assuming the font might be in a specific bundle
    var fileType: FileType
    
    init(fontFamily: String, weight: Weight, bundle: Bundle? = nil, fileType: FileType) {
      self.fontFamily = fontFamily
      self.weight = weight
      self.bundle = bundle
      self.fileType = fileType
    }
    
    // You can also add a method to get the full font name or path based on the config
    func fontName() -> String {
      // Example: "FontFamily-Bold"
      return "\(fontFamily)-\(weight.rawValue.capitalized)"
    }
    
    func fontPath() -> String {
      // Example: "FontFamily-Bold.otf"
      return "\(fontName()).\(fileType.rawValue)"
    }
  }
}

public extension FontAsset.FontConfig {
  static let bold = FontAsset.FontConfig(fontFamily: "Pretandard-Bold", weight: .bold, fileType: .ttf)
  static let regular = FontAsset.FontConfig(fontFamily: "Pretandard-Regular", weight: .regular, fileType: .ttf)
}
