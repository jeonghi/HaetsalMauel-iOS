//
//  OTPCustomKeyboard.swift
//  App
//
//  Created by 쩡화니 on 11/12/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import DesignSystemFoundation
import UISystem

public struct OTPCustomKeyboardView: View {
  
  // variable data is the data model
  
  @Binding var OTPdata: String
  
  // rows are the array of values that can be used in numerical kayboard
  
  var rows = ["1","2","3","4","5","6","7","8","9","","0","delete.left",]
  
  var keyboardColor = Color(.white)
  
  init(_ OTPdata: Binding<String>){
    self._OTPdata = OTPdata
  }
  public var body: some View {
    
    // MARK: - MainVStack
    VStack{
      
      LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: UIScreen.main.bounds.size.width/18.75), count: 3), spacing: 30){
        
        ForEach(rows,id:\.self){value in
          
          // Below Button is for keyboard Button and functionality
          
          Button(action: {
            
            //keyboard Button Action
            
            buttonAction(value:value)
          }){
            
            ZStack{
              if value == "delete.left" {
                ImageAsset.지우기.toImage().renderingMode(.template)
                  .resizable()
                  .foregroundColor(Color(.black))
                  .aspectRatio(contentMode: .fit)
              } else{
                Text(value)
                  .font(.largeTitleB)
                  .foregroundColor(.black)
              }
            }
            .aspectRatio(122/46, contentMode: .fit)
            .frame(maxWidth: .infinity)
            .background(value == "" ? keyboardColor: Color(.white))
            .cornerRadius(10)
          }
        }
      }
      .padding()
      .background(keyboardColor)
    }
    
    //MainVstack
    
  }
  
  //To get the width of CustomNumericalKeyboard
  
  func getWidth(frame:CGRect)->CGFloat{
    
    let width = frame.width
    
    let actualWidth = width - (UIScreen.main.bounds.size.width/9.375)
    
    return actualWidth / 3
    
  }
  
  func getCodeAtIndex(index: Int) -> String {
    if OTPdata.count > index {
      let start = OTPdata.startIndex
      let current = OTPdata.index(start, offsetBy: index)
      return String(OTPdata[current])
    }
    return ""
  }
  
  //To get the Height of CustomNumericalKeyboard
  
  func getHeight(frame:CGRect)->CGFloat{
    
    let height = frame.height
    
    let actualHeight = height - ((UIScreen.main.bounds.size.height < 800) ? (UIScreen.main.bounds.size.height/14.72):(UIScreen.main.bounds.size.height/27.0666667))
    
    return actualHeight / 4
  }
  
  //CustomNumericalKeyboard Button Action
  
  func buttonAction(value:String){
    
    //CustomNumericalKeyboard Button Action when delete is pressed
    
    if value == "delete.left" && OTPdata != ""{
      
      OTPdata.removeLast()
      
    }
    //CustomNumericalKeyboard Button Action when pressing numerical
    
    if value != "delete.left"{
      if OTPdata.count < 4 {
        OTPdata.append(contentsOf: value)
      }
      if OTPdata.count == 4 {
        
      }
    }
    
  }
}

#Preview {
  @State var data: String = ""
  return OTPCustomKeyboardView($data)
}
