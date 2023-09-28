//
//  ImageAsset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/24.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

public struct ImageAsset {
    
    struct Format {
        let fileExtension: String
        let convert: (ImageAsset) -> NSObjectProtocol
    }
    
    var named: String
    var bundle: Bundle
    var format: Format
    
    init(_ named: String, in bundle: Bundle, format: Format) {
        self.named = named
        self.bundle = bundle
        self.format = format
    }
}

extension ImageAsset {
    
    func toImage() -> Image {
        if let uiImage = format.convert(self) as? UIImage {
            return Image(uiImage: uiImage)
        }
        
        fatalError("Failed to convert ImageAsset to SwiftUI Image")
    }
    
    func toUIImage() -> UIImage {
        if let uiImage = format.convert(self) as? UIImage {
            return uiImage
        }
        fatalError("Failed to convert ImageAsset to UIImage")
    }
}

extension ImageAsset.Format {
    static let image = ImageAsset.Format(fileExtension: "assets") {
        UIImage(named: $0.named, in: $0.bundle, with: nil)!
    }
    
//    static let gif = ImageAsset.Format(fileExtension: "gif") {
//        guard let fileURL = $0.bundle.url(forResource: $0.named, withExtension: "gif"), let gifData = try? Data(contentsOf: fileURL) else {
//            fatalError("Failed to convert file to object")
//        }
//        // animatedImage로 custom 된 object를 반환
//        return UIImage.gif(data: gifData)
//    }
}

extension ImageAsset {
    // Initializing
    static let sampleImage = ImageAsset("sample_image", in: .main, format: .image)
//    static let sampleAnimatedImage = ImageAsset("sample_gif", in: .main, format: .gif)
}
