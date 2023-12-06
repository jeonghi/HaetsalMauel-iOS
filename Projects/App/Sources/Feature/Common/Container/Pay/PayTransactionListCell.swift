//
//  PayTransactionListCell.swift
//  UISystem
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import DesignSystemFoundation
import UISystem
import Kingfisher

public struct PayTransactionListCell {
  let transaction: TransactionEntity.History
}

extension PayTransactionListCell: View {
  
  public var body: some View {
    HStack(alignment: .top, spacing: 10){
      ZStack {
        KFImage(URL(string: transaction.opponentInfo.avatarPhotoUrl))
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxHeight: .infinity)
          .clipShape(Circle())
      }
      .frame(width: 32, height: 32)
      VStack(alignment: .leading, spacing: 5){
        
        HStack(alignment: .center){
          var desc: String {
            let cardName = transaction.opponentInfo.cardName
            let nickName = transaction.opponentInfo.nickName
            if transaction.opponentInfo.cardName.isEmpty {
              return "\(nickName)"
            }else {
              return "\(nickName)(\(cardName))"
            }
          }
          Text(desc)
            .lineLimit(1)
            .font(.subB)
            .foregroundColor(Color(.systemgray07))
          Spacer()
          Text(transaction.createdTime.timeAgoString())
            .font(.descriptionR)
            .foregroundColor(Color(.systemgray07))
        }
        HStack(alignment: .center) {
          Text("\(transaction.transactionType == .입금 ? "+" : "-") \(transaction.amount) 햇살")
            .lineLimit(1)
            .font(.subB)
            .foregroundColor(
              {
                switch transaction.transactionType {
                case .입금:
                  return Color(.primary)
                case .출금:
                  return Color(.secondaryDark)
                }
              }()
            )
          Spacer()
          Text("잔액 \(transaction.myCurrentBalance) 햇살")
              .font(.subR)
              .foregroundColor(Color(.systemgray07))
        }
      }
      .foregroundColor(Color.black)
      .hLeading()
    }
  }
}

public extension PayTransactionListCell {
  enum TransactionType {
    case 보냄
    case 받음
  }
}

#Preview {
  VStack {
    Color.white
  }
}
