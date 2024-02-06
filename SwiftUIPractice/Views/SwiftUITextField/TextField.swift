//
//  TextField.swift
//  SwiftUIPractice
//
//  Created by tunko on 1/11/24.
//

import SwiftUI

struct UITextViewWrapper: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
 
        // iOS 16 이상에서 사용 가능한 텍스트 스캔 버튼 활성화
        if #available(iOS 16.0, *) {
            textView.textContentType = .oneTimeCode // 스캔된 텍스트 유형
        }
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: UITextViewWrapper

        init(_ textViewWrapper: UITextViewWrapper) {
            self.parent = textViewWrapper
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}

struct TextFieldView: View {
    @State var text = "가나다라"
    var body: some View {
        UITextViewWrapper(text: $text)

    }
}

#Preview {
    TextFieldView()
}
