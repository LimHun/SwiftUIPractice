////
////  SearchUserView.swift
////  SwiftUIPractice
////
////  Created by 임훈 on 2023/01/01.
////
//
//import SwiftUI
//import FirebaseFirestore
//
//struct SearchUserView: View {
//    
//    @State private var fetchedUsers: [User] = []
//    @State private var searchText: String = ""
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//            List {
//                ForEach(fetchedUsers) { user in
//                    NavigationLink {
//                        ReusableProfileContent(user: user)
//                    } label: {
//                        Text(user.username)
//                            .font(.callout)
//                            .hAlign(.leading)
//                    }
//                }
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle("Search User")
//            .searchable(text: $searchText)
//            .onSubmit(of: .search) {
//                /// - Fetch User From Fierbase
//                Task {
//                    await searchUsers()
//                }
//            }
//            .onChange(of: searchText, perform: { newValue in
//                if newValue.isEmpty {
//                    fetchedUsers = []
//                }
//            })
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Cancel") {
//                        dismiss()
//                    }
//                    .tint(.black)
//                }
//            }
//            .overlay {
//                if fetchedUsers.count == 0 {
//                    Text("결과없음")
//                    Spacer()
//                }
//            }
//            
//    }
//    
//    func searchUsers() async {
//        do {
//            let _ = searchText.lowercased()
//            let _ = searchText.uppercased()
//            
//            let documents = try await Firestore.firestore().collection("Users")
//                .whereField("username", isGreaterThanOrEqualTo: searchText)
//                .whereField("username", isLessThanOrEqualTo: "\(searchText)\u{f8ff}")
//                .getDocuments()
//            
//            let users = try documents.documents.compactMap { doc -> User? in
//                try doc.data(as: User.self)
//            }
//            
//            await MainActor.run(body: {
//                fetchedUsers = users
//            })
//            
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}
//
//struct SearchUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchUserView()
//    }
//}
