//
//  SocialMediaView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2022/12/19.
//

import SwiftUI

struct SocialMediaView: View {
    
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
