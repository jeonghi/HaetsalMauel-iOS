//
//  MPPostApplyListCell.swift
//  App
//
//  Created by 쩡화니 on 12/3/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import UISystem
import Kingfisher
import DesignSystemFoundation

struct MPPostApplyListCell: View {
  
  let viewModel: ViewModel
  
  init(_ viewModel: ViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    HStack(spacing: 10) {
      
      ZStack{
        KFImage(URL(string: viewModel.profileURL))
            .resizable()
            .scaledToFit()
            .padding(4)
            .background(viewModel.isChecked ? Color.clear : Color(.systemgray02))
            .clipShape(Circle())
      }
      .frame(width: 32, height: 32)
      .vTop()
      
        
      VStack(alignment: .leading, spacing: 4.5){
        HStack(spacing: 5) {
          Text("\(viewModel.nickName)")
            .font(.subB)
            .lineLimit(1)
            .foregroundColor(viewModel.isChecked ? Color(.primary) : Color(.black))
          Spacer()
          HStack(spacing: 8) {
            Text("선택")
              .font(.subB)
            ImageAsset.check.toImage()
              .renderingMode(.template)
              .resizable()
              .scaledToFit()
              .frame(height: 24)
          }
          .foregroundColor(viewModel.isChecked ? Color(.primary) : Color(.systemgray07))
        }
        
        VStack(alignment: .leading, spacing: 5){
          Text("\(viewModel.address)")
            .foregroundColor(viewModel.isChecked ? Color(.systemgray06) : Color(.systemgray07))
            .lineLimit(1)
            .font(.descriptionR)
          Text("\(viewModel.comment)")
            .lineLimit(1)
            .foregroundColor(Color(.black))
            .font(.subR)
        }
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 10)
    .frame(maxWidth: .infinity)
    .background(
      viewModel.isChecked ? Color(.primaryLight) : Color.white
    )
  }
}

extension MPPostApplyListCell {
  
  struct ViewModel: Hashable, Identifiable {
    let id: UUID = UUID()
    let profileURL: String
    let nickName: String
    let address: String
    let comment: String
    var isChecked: Bool
    
    init(_ applicant: MarketPostApplicationEntity.Response){
      profileURL = applicant.avatarPhotoUrl
      nickName = applicant.applicantNickName
      address = applicant.applicantAddress
      comment = applicant.introduction
      isChecked = applicant.isAccepted
    }
  }
}

#Preview {
  let entity: MarketPostApplicationEntity.Response = .init(applicantAddress: "정릉제2동", applicantId: 2, applicantNickName: "닉네임", applyId: 2, createdTime: Date(), introduction: "신청 한마디", isAccepted: true, postId: 2, avatarPhotoUrl: "")
  
  let vm: MPPostApplyListCell.ViewModel = .init(entity)
  return ScrollView {
    VStack(spacing: 0) {
      MPPostApplyListCell(vm)
    }
  }
}
