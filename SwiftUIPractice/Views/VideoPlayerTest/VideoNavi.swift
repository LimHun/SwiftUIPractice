//
//  VideoNavi.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/21.
//

import SwiftUI

struct VideoNavi: View {
    var body: some View {
        NavigationLink {
            VideoPlayerTest()
        } label: {
            Text("VideoPlayer")
        }
    }
}

struct VideoNavi_Previews: PreviewProvider {
    static var previews: some View {
        VideoNavi()
    }
}
