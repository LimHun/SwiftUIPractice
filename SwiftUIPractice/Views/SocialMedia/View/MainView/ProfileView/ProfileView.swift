////
////  ProfileView.swift
////  SwiftUIPractice
////
////  Created by 임훈 on 2022/12/20.
////
//
//import SwiftUI
//import Firebase
//import FirebaseStorage
//import FirebaseFirestore
//
//struct ProfileView: View {
//    
//    // MARK: My Profile Data
//    @State private var myProfile: User?
//    @AppStorage("log_status") var logStatus: Bool = false
//    
//    // MARK: View Properties
//    @State var errorMessage: String = ""
//    @State var showError: Bool = false
//    @State var isLoading: Bool = false
//    var body: some View {
//        NavigationStack {
//            VStack {
//                if let myProfile {
//                    ReusableProfileContent(user: myProfile)
//                        .refreshable {
//                            // MARK: Refresh User Data
//                            self.myProfile = nil
//                            await fetchUserData()
//                        }
//                } else {
//                    ProgressView()
//                }
//            }
//            .navigationTitle("My Profile")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Menu {
//                        // MARK: Two Action's
//                        // 1. Logout
//                        // 2. Delete Account
//                        Button("Logout", action: logOutUser)
//                        Button("Delete Account", role: .destructive, action: deleteAccount)
//                    } label: {
//                        Image(systemName: "ellipsis")
//                            .rotationEffect(.init(degrees: 90))
//                            .tint(.black)
//                            .scaleEffect(0.8)
//                    }
//                }
//            }
//        }
//        .overlay {
//            LoadingView(show: $isLoading)
//        }
//        .alert(errorMessage, isPresented: $showError) {
//            
//        }
//        .task {
//            if myProfile != nil { return }
//            
//            await fetchUserData()
//        }
//    }
//    
//    // MARK: fetchUserData
//    func fetchUserData() async {
//        guard let userUID = Auth.auth().currentUser?.uid else { return }
//        guard let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self) else { return }
//        await MainActor.run(body: {
//            myProfile = user
//        })
//    }
//    
//    // MARK: Loggin User Out
//    func logOutUser() {
//        try? Auth.auth().signOut()
//        logStatus = false
//    }
//    
//    // MARK: Deleting User Entire Account
//    func deleteAccount() {
//        isLoading = true
//        Task {
//            do {
//                guard let userUID = Auth.auth().currentUser?.uid else {
//                    return
//                }
//                let reference = Storage.storage().reference().child("Profile_Images").child(userUID)
//                try await reference.delete()
//                try await Firestore.firestore().collection("Users").document(userUID).delete()
//                try await Auth.auth().currentUser?.delete()
//                logStatus = false
//                
//            } catch {
//                await setError(error)
//            }
//        }
//    }
//    
//    // MARK: Setting Error
//    func setError(_ error: Error) async {
//        await MainActor.run(body: {
//            isLoading = false
//            errorMessage = error.localizedDescription
//            showError.toggle()
//        })
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
