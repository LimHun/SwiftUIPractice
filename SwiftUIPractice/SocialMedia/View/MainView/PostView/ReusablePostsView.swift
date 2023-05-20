//
//  ReusablePostsView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2022/12/27.
//

import SwiftUI
import Firebase

struct ReusablePostsView: View {
    var basedOnUID: Bool = false
    var uid: String = ""
    @Binding var posts: [Post]
    @State private var isFetching = true
    @State private var paginationDoc: QueryDocumentSnapshot?
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                if isFetching {
                    ProgressView()
                        .padding(.top, 30)
                } else {
                    if posts.isEmpty {
                        /// No Post's Found on Firestore
                        Text("No Posts's Found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                    } else {
                        /// Displaying Post's
                        postsView()
                    }
                }
            }
            .padding(15)
        }
        .refreshable {
            // scroll to refresh
            // Disbaling Refresh for UID based Post's
            guard !basedOnUID else { return }
            isFetching = true
            posts = []
            
            // Resetting Pagination Doc
            paginationDoc = nil
            await fetchPosts()
        }
        .task {
            guard posts.isEmpty else {
                return
            }
            await fetchPosts()
        }
    }
    
    @ViewBuilder
    func postsView() -> some View {
        ForEach(posts) { post in
            PostCardView(post: post) { updatedPost in
                if let index = posts.firstIndex(where: { post in
                    post.id == updatedPost.id
                }) {
                    posts[index].likedIDs = updatedPost.likedIDs
                    posts[index].dislikedIDs = updatedPost.dislikedIDs
                }
            } onDelete: {
                withAnimation(.easeInOut(duration: 0.25)) {
                    posts.removeAll { post.id == $0.id }
                }
            }
            .onAppear {
                // when last post appears, Fetching new post(If there)
                if post.id == posts.last?.id && paginationDoc != nil {
                    Task {
                        await fetchPosts()
                    }
                }
            }
            
            Divider()
                .padding(.horizontal, -15)
        }
    }
    
    /// - Fetching Post's
    func fetchPosts() async {
//        do {
//            var query: Query!
//            if let paginationDoc {
//                query = Firestore.firestore().collection("Posts")
//                    .order(by: "publishedDate", descending: true)
//                    .start(afterDocument: paginationDoc)
//                    .limit(to: 20)
//            } else {
//                query = Firestore.firestore().collection("Posts")
//                    .order(by: "publishedDate", descending: true)
//                    .limit(to: 20)
//            }
//            
//            // New Query For UID Based Document Fetch
//            // Simply Filter the Post's Which is not belongs to the UID
//            if basedOnUID {
//                query = query
//                    .whereField("userUID", isEqualTo: uid)
//            }
//            
////            let docs = try await query.getDocuments()
////            let fetchedPosts = docs.documents.compactMap { doc -> Post? in
////                try? doc.data(as: Post.self)
////            }
////            await MainActor.run(body: {
////                posts.append(contentsOf: fetchedPosts)
////                paginationDoc = docs.documents.last
////                isFetching = false
////            })
//        } catch {
//            print(error.localizedDescription)
//        }
    }
}

struct ReusablePostsView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
