//
//  MPPostCommentListCell.swift
//  App
//
//  Created by 쩡화니 on 11/29/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import UISystem
import SwiftUI
import Kingfisher
import DesignSystemFoundation

struct MPPostCommentListCell: View {
  
  @State var isShowingBottomPopup: Bool = false
  let comment: MarketPostCommmentEntity.Response
  var deleteAction: ((Int64) -> Void)? = nil
  var blockAction: ((Int64) -> Void)? = nil
  
  var body: some View {
    HStack(spacing: 10) {
      KFImage(URL(string: comment.writerInfo.avatarPhotoUrl))
        .resizable()
        .scaledToFit()
        .frame(height: 26)
        .clipShape(Circle())
        .vTop()
      VStack(alignment: .leading, spacing: 4.5){
        HStack(spacing: 5) {
          Text("\(comment.writerInfo.nickName)")
            .font(.subB)
          if(comment.isPostWriter){
            Text("작성자")
              .font(.descriptionR)
              .foregroundColor(Color(.systemgray07))
              .padding(.horizontal, 5)
              .padding(.vertical, 3)
              .background(
                RoundedRectangle(cornerRadius: 4)
                  .fill(Color(.systemgray02))
              )
          }
          Spacer()
          Button(action: {
            isShowingBottomPopup = true
          }){
            ImageAsset.기타_작은.toImage()
              .renderingMode(.template)
              .resizable()
              .scaledToFit()
              .foregroundColor(Color(.systemgray07))
              .frame(height: 24)
          }
        }
        
        VStack(alignment: .leading, spacing: 5){
          Text("\(comment.writerInfo.address) \(comment.createdTime.timeAgoString())")
            .foregroundColor(Color(.systemgray07))
            .font(.descriptionR)
          Text("\(comment.commentContent)")
            .foregroundColor(Color(.black))
            .font(.subR)
        }
      }
    }
    .frame(maxWidth: .infinity)
    .background(
      Color(.white)
    )
    .eumActionSheet(
      isShowing: $isShowingBottomPopup,
      buttons:
        comment.isCommentWriter ? [
          .init(title: "댓글 삭제", action: {
            deleteAction?(comment.commentId)
            isShowingBottomPopup = false
          })
        ] : [
          .init(title: "댓글 차단", action: {
            blockAction?(comment.writerInfo.userId)
            isShowingBottomPopup = false
          })
        ]
    )
  }
}

#Preview {
  return VStack {
    MPPostCommentListCell(comment: .init(commentContent: "하하", commentId: 6, createdTime: Date(), isCommentWriter: true, isPostWriter: true, postId: 65, writerInfo: .init(address: "정릉 3동", avatarPhotoUrl: "", nickName: "꽥꽥이", userId: 44)))
    MPPostCommentListCell(comment: .init(commentContent: "하하", commentId: 6, createdTime: Date(), isCommentWriter: true, isPostWriter: false, postId: 65, writerInfo: .init(address: "정릉 3동", avatarPhotoUrl: "", nickName: "꽥꽥이", userId: 44)))
  }
}
