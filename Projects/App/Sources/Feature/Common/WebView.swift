//
//  EumWebView.swift
//  App
//
//  Created by 쩡화니 on 11/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
  var url: URL?
  
  func makeUIView(context: Context) -> WKWebView {
    guard let url = url else {
      return WKWebView()
    }
    
    let webView = WKWebView()
    webView.load(URLRequest(url: url))
    return webView
  }
  
  func updateUIView(_ webView: WKWebView, context: Context) { }
}


#Preview {
  return VStack {
    WebView(url: "https://accounts.kakao.com/login/?continue=https%3A%2F%2Fkauth.kakao.com%2Foauth%2Fauthorize%3Fresponse_type%3Dcode%26redirect_uri%3Dhttp%253A%252F%252Fsunrise.k-eum.kr%253A8080%252Fuser%252Fauth%252Fkakao%26through_account%3Dtrue%26client_id%3D1a354a3d4dc989747906944c3c188196#login".toURL())
  }
}
