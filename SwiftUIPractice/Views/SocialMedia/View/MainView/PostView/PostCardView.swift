////
////  PostCardView.swift
////  SwiftUIPractice
////
////  Created by 임훈 on 2022/12/30.
////
//
//import SwiftUI
//import SDWebImageSwiftUI
//import Firebase
//import FirebaseStorage
//
//struct PostCardView: View {
//    
//    var post: Post
//    // callbacks
//    var onUpdate: (Post) -> Void
//    var onDelete: () -> Void
//    // View Properties
//    @AppStorage("user_UID") var userUID: String = ""
//    @State private var docListner: ListenerRegistration?
//    
//    var body: some View {
//        HStack(alignment: .top, spacing: 12) {
//            WebImage(url: post.userProfileURL)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 35, height: 35)
//                .clipShape(Circle())
//            
//            VStack(alignment: .leading, spacing: 6) {
//                Text(post.userName)
//                    .font(.callout)
//                    .fontWeight(.semibold)
//                Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
//                    .font(.caption2)
//                    .foregroundColor(.gray)
//                Text(post.text)
//                    .textSelection(.enabled)
//                    .padding(.vertical, 8)
//                
//                if let postImageURL = post.imageURL {
//                    GeometryReader {
//                        let size = $0.size
//                        WebImage(url: postImageURL)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: size.width, height: size.height)
//                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//                    }
//                    .frame(height: 200)
//                }
//                
//                postInteraction()
//            }
//        }
//        .hAlign(.leading)
//        .overlay(alignment: .topTrailing, content: {
//            if post.userUID == userUID {
//                Menu {
//                    Button("Delete Post", role: .destructive, action: deletePost)
//                } label: {
//                    Image(systemName: "ellipsis")
//                        .font(.caption)
//                        .rotationEffect(.init(degrees: -90))
//                        .foregroundColor(.black)
//                        .padding(8)
//                        .contentShape(Rectangle())
//                }
//                .offset(x: 8)
//            }
//        })
//        .onAppear {
//            if docListner == nil {
//                guard let postID = post.id else { return }
//                docListner = Firestore.firestore().collection("Posts").document(postID).addSnapshotListener({ snapshot, _ in
//                    if let snapshot {
//                        if snapshot.exists {
////                            if let updatedPost = try? (snapshot.data() as? Post) {
////                                onUpdate(updatedPost)
////                            }
//                        } else {
//                            onDelete()
//                        }
//                    }
//                })
//            } 
//        }
//        .onDisappear {
//            // MARK: Applying SnapShot Listner Only When the Post is Available on the Screen
//            // Else Removing the Listner (It saves unwanted live updates from the post which was swiped away from the screen)
//            if let docListner {
//                docListner.remove()
//                self.docListner = nil
//            }
//        }
//    }
//    
//    // MARK: Like/Dislike Interaction
//    @ViewBuilder
//    func postInteraction() -> some View {
//        HStack(spacing: 6) {
//            Button {
//                likePost()
//            } label: {
//                Image(systemName: post.likedIDs.contains(userUID) ? "hand.thumbsup.fill" : "hand.thumbsup")
//            }
//            
//            Text("\(post.likedIDs.count)")
//                .font(.caption)
//                .foregroundColor(.gray)
//            
//            Button {
//                dislikePost()
//            } label: {
//                Image(systemName: post.dislikedIDs.contains(userUID) ? "hand.thumbsdown.fill" : "hand.thumbsdown")
//            }
//            .padding(.leading, 25)
//
//            Text("\(post.dislikedIDs.count)")
//                .font(.caption)
//                .foregroundColor(.gray)
//        }
//    }
//    
//    // liking post
//    func likePost() {
//        Task {
//            guard let postID = post.id else { return }
//            if post.likedIDs.contains(userUID) {
//                try await Firestore.firestore().collection("Posts").document(postID).updateData([
//                    "likedIDs": FieldValue.arrayRemove([userUID])
//                ])
//            } else {
//                try await Firestore.firestore().collection("Posts").document(postID).updateData([
//                    "likedIDs": FieldValue.arrayUnion([userUID]),
//                    "dislikedIDs": FieldValue.arrayRemove([userUID])
//                ])
//            }
//        }
//    }
//    
//    func dislikePost() {
//        Task {
//            guard let postID = post.id else { return }
//            if post.dislikedIDs.contains(userUID) {
//                try await Firestore.firestore().collection("Posts").document(postID).updateData([
//                    "dislikedIDs": FieldValue.arrayRemove([userUID])
//                ])
//            } else {
//                try await Firestore.firestore().collection("Posts").document(postID).updateData([
//                    "likedIDs": FieldValue.arrayRemove([userUID]),
//                    "dislikedIDs": FieldValue.arrayUnion([userUID])
//                ])
//            }
//        }
//    }
//    
//    // deleting Post
//    func deletePost() {
//        Task {
//            do {
//                if post.imageReferenceID != "" {
//                    try await Storage.storage().reference().child("Post_Images").child(post.imageReferenceID).delete()
//                }
//                
//                guard let postID = post.id else {
//                    return
//                }
//                
//                try await Firestore.firestore().collection("Posts").document(postID).delete()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//} 
