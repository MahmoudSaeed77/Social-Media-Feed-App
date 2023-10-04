//
//  HomeVM.swift
//  SM Feed
//
//  Created by imac on 03/10/2023.
//

import Foundation

class HomeVM {
    
    
    private weak var view: HomeVC!
    
    var postsData: [TimeLineModel] = [TimeLineModel]()
    
    var posts: [TimeLineModel] {
        return self.postsData.sorted(by: {$0.date ?? Date() < $1.date ?? Date()})
    }
    
    init(view: HomeVC) {
        self.view = view
        self.getPosts()
    }
    
    func getPosts() {
        Constants.databaseRef.collection("Posts").getDocuments { snapshot, err in
            guard err == nil else {
                
                return
            }
            
            if let posts = snapshot?.documents {
                self.postsData.removeAll()
                posts.forEach { post in
                    let caption = post.get("caption") as? String ?? ""
                    let imageUrl = post.get("imageUrl") as? String ?? ""
                    let postId = post.get("postId") as? String ?? ""
                    let date = post.get("date") as? Date ?? Date()
                    let uid = post.get("uid") as? String ?? ""
                    
                    Constants.databaseRef.collection("Users").document(uid).getDocument { snapshot, err in
                        guard err == nil else {
                            print(err?.localizedDescription ?? "")
                            return
                        }
                        
                        if let user = snapshot?.data() {
                            let username = user["username"] as? String ?? ""
                            let email = user["email"] as? String ?? ""
                            let profileImageUrl = user["profileImageUrl"] as? String ?? ""
                            let gender = user["gender"] as? String ?? ""
                            let userData = UserModel(uid: uid, username: username, email: email, profileImageUrl: profileImageUrl, gender: gender)
                            let post = TimeLineModel(caption: caption, imageUrl: imageUrl, uid: uid, postId: postId, date: date, user: userData)
                            self.postsData.append(post)
                            self.view.reloadTable()
                        }
                    }
                }
            }
        }
    }
    
    func reactPost(postId: String) {
        
    }
}
