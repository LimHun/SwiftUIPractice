//
//  TinderHome.swift
//  SwiftUIPractice
//
//  Created by tunko on 3/18/24.
//

import SwiftUI

struct TinderHome: View {
    
    @StateObject var vm: TinderVM = TinderVM()
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Image("Menu")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
            }
            .frame(maxWidth: .infinity,  alignment: .leading)
            .overlay {
                Text("Discover")
                    .font(.title.bold())
            }
            .foregroundColor(.black)
            .padding()
            
            ZStack {
                if let users = vm.displaying_users {
                    if users.isEmpty {
                        Text("Come back later we can find more matches for you!")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        // Displaying Cards
                        // Cards are reversed since its Zstack..
                        // you can user reverse here...
                        // or you can use while fetching users...
                        
                        ForEach(users.reversed()) { user in
                            // Card View...
                            TinderStackCardView(user: user)
                                .environmentObject(vm)
                        }
                    }
                }
            }
            .padding(.top, 30)
            .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color("Gray"))
                        .clipShape(Circle())
                }
                
                Button {
                    doSwipe(rightSwipe: true)
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color("Blue"))
                        .clipShape(Circle())
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color("Yellow"))
                        .clipShape(Circle())
                }
                
                Button {
                    doSwipe()
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color("Pink"))
                        .clipShape(Circle())
                }
            }
            .padding(.bottom)
            .disabled(vm.displaying_users?.isEmpty ?? false)
            .opacity((vm.displaying_users?.isEmpty ?? false) ? 0.6 : 1)
        }
    }
    
    // removing cards when doing Swipe...
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = vm.displaying_users?.first else {
            return
        }
        
        // Using Notification to post and receiving in stack Cards...
        NotificationCenter.default.post(name: Notification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
}

#Preview {
    TinderHome()
}
