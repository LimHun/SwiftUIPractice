//
//  UINavigationController+Extension.swift
//  SwiftUIPractice
//
//  Created by tunko on 2023/04/27.
//

import SwiftUI

// MARK: SwiftUI NavigationView or NavigationStack 에서 기본적으로 제공하지 않는 Swipe back 기능을 추가
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension UIApplication {
    func rootController() -> UIViewController {
        guard let window = connectedScenes.first as? UIWindowScene else { return .init() }
        guard let viewcontroller = window.windows.last?.rootViewController else { return .init() }
        return viewcontroller
    }
}
