//
//  OTPView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2022/12/24.
//

import SwiftUI

struct OTPView: View {
    var body: some View {
        if #available(iOS 15, *) {
            NavigationView {
                OTPVerificationView()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
            }
        } else {
            NavigationStack {
                OTPVerificationView()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}
