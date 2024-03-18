//
//  TinderStackCardView.swift
//  SwiftUIPractice
//
//  Created by tunko on 3/19/24.
//

import SwiftUI

struct TinderStackCardView: View {
    @EnvironmentObject var vm: TinderVM
    var user: TinderUser
    
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let index = CGFloat(vm.getIndex(user: user))
            let topOffset = (index <= 2 ? index: 2) * 15
            
            ZStack {
                Image(user.profilePic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width - topOffset, height: size.height)
                    .cornerRadius(15)
                    .offset(y: -topOffset)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 8)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
        .gesture(
            DragGesture()
                .updating($isDragging, body: { value, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                })
                .onEnded({ value in
                    let width = getRect().width - 50
                    let translation = value.translation.width
                    
                    let checkingStatus = (translation > 0 ? translation : -translation)
                    
                    withAnimation {
                        if checkingStatus > (width / 2) {
                            // remove Card...
                            offset = (translation > 0 ? width : -width) * 2
                            endSwipeActions()
                            
                            if translation > 0 {
                                rightSwipe()
                            } else {
                                leftSwipe()
                            }
                        } else {
                            offset = .zero
                        }
                    }
                })
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON")), perform: { data in
            guard let info = data.userInfo else {
                return
            }
            let id = info["id"] as? String ?? ""
            let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = getRect().width - 50
            if user.id == id {
                withAnimation {
                    offset = (rightSwipe ? width : -width) * 2
                    endSwipeActions()
                    
                    if rightSwipe {
                        self.rightSwipe()
                    } else {
                        self.leftSwipe()
                    }
                }
            }
        })
    }
    
    func getRotation(angle: Double) -> Double {
        (offset / (getRect().width - 50)) * angle
    }
    
    func endSwipeActions() {
        withAnimation {
            endSwipe = true
            
            // After the card is moved away removing the card from array to preserve the momory...
            
            // The delay time based on your animation duration...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let _ = vm.displaying_users?.first {
                    let _ = withAnimation {
                        vm.displaying_users?.removeFirst()
                    }
                }
            }
        }
    }
    
    func leftSwipe() {
        print("Left Swiped")
    }
    
    func rightSwipe() {
        print("Left Swiped")
    }
}

#Preview {
    TinderHome()
}

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
}
