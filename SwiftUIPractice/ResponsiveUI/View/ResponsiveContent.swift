//
//  ResponsiveContent.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/06.
//

import SwiftUI

struct ResponsiveContent: View {
    var body: some View {
        ResponsiveView { props in
            ResponsiveHome(props: props)
        }
    }
}

struct ResponsiveContent_Previews: PreviewProvider {
    static var previews: some View {
        ResponsiveContent()
    }
}
