//
//  SafariView.swift
//  SwiftUIPractice
//
//  Created by tunko on 1/7/24.
//

import SwiftUI
import SafariServices

struct SafariView: View {
    let url: URL
    
    @State var isSafari: Bool = false
    var body: some View {
        VStack {
            Button {
                isSafari.toggle()
            } label: {
                Text("웹뷰열기")
                    .font(.headline)
                    .foregroundStyle(.foreground)
            }
        }
        .fullScreenCover(isPresented: $isSafari) {
            SafariViewController(url: url)
        }
    }
}

struct SafariViewController: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
 
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Update the view controller if needed.
    }
}
#Preview {
    SafariView(url: URL(string: "https://product.kyobobook.co.kr/detail/S000001913217")!)
}
