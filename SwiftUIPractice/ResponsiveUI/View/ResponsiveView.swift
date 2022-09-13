//
//  ResponsiveView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/06.
//

import SwiftUI

struct ResponsiveView<Content: View>: View {

    var content: (Properties)-> Content
    init(@ViewBuilder content: @escaping (Properties) -> Content) {
        self.content = content
    }

    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            let isLandscpe = size.width > size.height
            let isIpad = UIDevice.current.userInterfaceIdiom == .pad
            let isMaxSplit = isSplit() && size.width < 400
            let properties = Properties(isLandscape: isLandscpe, isiPad: isIpad, isSplit: isSplit(), isMaxSplit: isMaxSplit, size: size)
            content(properties)
                .frame(width: size.width, height: size.height)
        }
    }

    // MARK: Simple Way to Find it the app is in Split View
    func isSplit() -> Bool {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return false
        }
        return screen.windows.first?.frame.size != screen.screen.bounds.size
    }
}

//struct ResponsiveView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResponsiveView()
//    }
//}

struct Properties {
    var isLandscape: Bool
    var isiPad: Bool
    var isSplit: Bool
    // MARK: If the App size is reduced more than 1/3 in split mode on iPad
    var isMaxSplit: Bool
    var size: CGSize
}
