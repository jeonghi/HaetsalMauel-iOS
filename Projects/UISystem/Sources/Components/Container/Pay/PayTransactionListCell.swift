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

public struct PayTransactionListCell {
  let description: String
  let transactionAt: Date
  let type: TransactionType
  let amount: Int64
  let balance: Int64
  
  public init(description: String, transactionAt: Date, type: TransactionType, amount: Int64, balance: Int64) {
    self.description = description
    self.transactionAt = transactionAt
    self.type = type
    self.amount = amount
    self.balance = balance
  }
}

extension PayTransactionListCell: View {
  
  public var body: some View {
    HStack(alignment: .top, spacing: 10){
      Circle()
        .fill(Color(.systemgray02))
        .frame(width: 32, height: 32)
      VStack(alignment: .leading, spacing: 5){
        
        HStack(alignment: .center){
          Text(description)
            .lineLimit(1)
            .font(.subB)
            .foregroundColor(Color(.systemgray07))
          Spacer()
          Text(transactionAt.formattedTimeWithAmPm())
            .font(.descriptionR)
            .foregroundColor(Color(.systemgray07))
        }
        HStack(alignment: .center) {
          Text("\(type == .받음 ? "+" : "-") \(amount) 햇살")
            .lineLimit(1)
            .font(.subB)
            .foregroundColor(
              {
                switch type {
                case .받음:
                  return Color(.primary)
                case .보냄:
                  return Color(.secondaryDark)
                }
              }()
            )
          Spacer()
          Text("잔액 \(balance) 햇살")
              .font(.descriptionR)
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
    PayTransactionListCell(description: "거래내용", transactionAt: Date(), type: .받음, amount: 20, balance: 2000)
    PayTransactionListCell(description: "거래내용", transactionAt: Date(), type: .보냄, amount: 40, balance: 2000)
    PayTransactionListCell(description: "거래내용", transactionAt: Date(), type: .보냄, amount: 40, balance: 2000)
  }
}
