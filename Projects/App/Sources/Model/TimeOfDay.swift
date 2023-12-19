//
//  TimeOfDay.swift
//  App
//
//  Created by 쩡화니 on 12/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

enum TimeOfDay {
    case day // 낮
    case night // 밤
}

// Date Extension
extension Date {
    var timeOfDayInKorea: TimeOfDay {
        // 한국 시간대를 설정
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!

        // 현재 시간을 한국 시간대로 가져옵니다.
        let hour = calendar.component(.hour, from: self)

        // 시간대를 결정합니다 (예: 6시부터 18시까지를 낮으로 정의)
        switch hour {
        case 6..<18:
            return .day
        default:
            return .night
        }
    }
}
