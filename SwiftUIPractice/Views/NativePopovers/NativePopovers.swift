//
//  NativePopovers.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/01/24.
//
// popover기능은 macOS iPadOS 에서는 제공됩니다 하지만 iOS는 sheet 형태로 나오기 때문에 이를 가능하게 하는것을 구현해봅니다.

import SwiftUI
import UIKit

struct NativePopovers: View {
    
    @State private var showPopover: Bool = false
    @State private var updateText: Bool = false
    var body: some View {
        Button {
            showPopover.toggle()
        } label: {
            Text("Show popover")
        }
        .iOSPopover(isPresented: $showPopover, arrowDirection: .left) {
            VStack(spacing: 12) {
                Text("Hello \(updateText ? "업데이트" : "업데이트 아님")")
                    .padding(15)
                
                Button {
                    updateText.toggle()
                } label: {
                    Text("Update Text")
                }
                
                Button {
                    showPopover.toggle()
                } label: {
                    Text("Close popover")
                }

            }
            .foregroundColor(.white)
            .padding(20)
            // you can also give full popover color like this
            .background {
                Rectangle()
                    .fill(.blue.gradient)
                    .padding(-20)
            }
        }
//        .popover(isPresented: $showPopover) {
//            Text("Hello, it's me, Popover")
//        }
    }
}

struct NativePopovers_Previews: PreviewProvider {
    static var previews: some View {
        NativePopovers()
    }
}

extension View {
    @ViewBuilder
    func iOSPopover<Content: View>(isPresented: Binding<Bool>, arrowDirection: UIPopoverArrowDirection, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.background {
            PopOverController(isPresented: isPresented, arrowDirection: arrowDirection, content: content())
        }
    }
}

struct PopOverController<Content: View>: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    var arrowDirection: UIPopoverArrowDirection
    var content: Content
    
    @State private var alreadyPresented: Bool = false
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if alreadyPresented {
            
            // updating swiftUI view, when it's Changed
            if let hostingController = uiViewController.presentedViewController as? CustomHostingView<Content> {
                hostingController.rootView = content
                // updating view size when it's update
                // or you can define your own size in swiftUI view
                hostingController.preferredContentSize = hostingController.view.intrinsicContentSize
            }
            
            // close view, if it's toggled back
            if !isPresented {
                uiViewController.dismiss(animated: true) {
                    // resetting alreadyPresented State
                    alreadyPresented = false
                }
            }
        } else {
            if isPresented {
                /// presenting popover
                let controller = CustomHostingView(rootView: content)
                controller.view.backgroundColor = .clear
                controller.modalPresentationStyle = .popover
                controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
                
                controller.presentationController?.delegate = context.coordinator
                // we Need to attach the source view so that it will show arrow at correct position
                controller.popoverPresentationController?.sourceView = uiViewController.view
                // simply presenting popover controller
                uiViewController.present(controller, animated: true)
            }
        }
    }
    
    // forcing it to show popover using presentationDelegate
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        var parent: PopOverController
        
        init(parent: PopOverController) {
            self.parent = parent
        }
    
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
        }
        
        // when the popover is presented, updating the alreadyPresented state
        func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
            DispatchQueue.main.async {
                self.parent.alreadyPresented = true
            }
        }
    }
}

// custom hosting controller for wrapping to it's swiftUI view size
class CustomHostingView<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = view.intrinsicContentSize
    }
}
