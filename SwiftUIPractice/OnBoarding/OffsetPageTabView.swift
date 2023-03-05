//
//  OffsetPageTabView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2023/03/05.
//

import SwiftUI

struct OffsetPageTabView<Content: View>: UIViewRepresentable {
    
    var content: Content
    @Binding var offset: CGFloat
    
    func makeCoordinator() -> Coordinator {
        return OffsetPageTabView.Coordinator(parent: self)
    }
    
    init(offset: Binding<CGFloat>, @ViewBuilder content: @escaping ()->Content) {
        self.content = content()
        self._offset = offset
    }
    
    func makeUIView(context: Context) -> some UIScrollView {
    
        let scrollView = UIScrollView()
        
        let hostview = UIHostingController(rootView: content)
        hostview.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostview.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostview.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostview.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostview.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // if you are using vertical paging...
            // then dont declare height constraint...
            hostview.view.topAnchor.constraint(equalTo: scrollView.topAnchor)
        ]
        
        scrollView.addSubview(hostview.view)
        scrollView.addConstraints(constraints)
        
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        // setting Delegate...
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        let currentOffset = uiView.contentOffset.x
        if currentOffset != offset {
            print("updating")
            uiView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: OffsetPageTabView
        
        init(parent: OffsetPageTabView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
            parent.offset = offset
        }
    }
}

