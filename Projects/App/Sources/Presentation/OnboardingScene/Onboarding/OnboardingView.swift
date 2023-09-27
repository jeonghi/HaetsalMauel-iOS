//
//  OnboardingView.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        
        VStack(spacing: 0) {
            
            // 타이틀
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    // 메인 타이틀
                    Text("모두에게 동일한 시간\n시간을 거래하는 타임페이")
                    
                    // 서브 타이틀
                    Text("나의 시간을 가치있게 써보아요")
                }
                Spacer()
            }
            .padding(.horizontal, 22)
            .padding(.top, 72)
            
            Spacer()
            
            // 임시 이미지
            Color.gray
                .frame(width: 100, height: 100)
                .padding(.top, 77)
            
            // 둘러보기
            Button(action: {}){
                Text("시작전에 둘러보기")
            }
            .padding(.top, 48)
            .padding(.bottom, 78)
            
            Spacer()
            
            VStack {
                Button(action: {}){
                    Text("타임페이 시작하기")
                }
                Button(action: {}){
                    Text("카카오로 시작하기")
                }
                Button(action: {}){
                    Text("Apple로 시작하기")
                }
            }
            .padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
