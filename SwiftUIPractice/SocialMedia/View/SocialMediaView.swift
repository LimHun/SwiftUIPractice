//
//  SocialMediaView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2022/12/19.
//

import SwiftUI

struct SocialMediaView: View {
    
    // 로그인 여부 확인 - 앱이 다시 켜져도 설정된 값이 유지
    // 기본 값은 false
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        if logStatus {
            MainView()
        } else {
            LoginView()
        }
    }
}

struct SocialMediaView_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaView()
    }
}
