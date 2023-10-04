//
//  AddpostVM.swift
//  SM Feed
//
//  Created by imac on 03/10/2023.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class AddpostVM {
    
    private weak var view: AddpostVC!
    
    init(view: AddpostVC) {
        self.view = view
    }
    
    
    func uploadImage() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let imageData = self.view.imgView.image?.jpegData(compressionQuality: 0.4) else {return}
        let imageRef = Constants.storageRef.child("Posts").child(uid).child("\(Int.random(in: 1...9000))\(uid)\(Int.random(in: 1...9000)).jpg")
        imageRef.putData(imageData, metadata: nil) { metadata, err in
            guard self.view != nil else {return}
            guard err == nil else {
                self.uploadPost(nil)
                return
            }
            imageRef.downloadURL(completion: { url, err in
                guard err == nil else {
                    self.uploadPost(nil)
                    return
                }
                guard let imageUrl = url?.absoluteString else {
                    self.uploadPost(nil)
                    return
                }
                self.uploadPost(imageUrl)
            })
        }
    }
    
    
    func uploadPost(_ postImageUrl: String?) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data: [String: Any] = [
            "caption" : self.view.postField.text ?? "",
            "imageUrl" : postImageUrl ?? "",
            "date" : FieldValue.serverTimestamp(),
            "uid" : uid
        ]
        
        let documentRef = Constants.databaseRef.collection("Posts").addDocument(data: data) { err in
            guard err == nil else {
                return
            }
        }
        Constants.databaseRef.collection("Posts").document(documentRef.documentID).updateData(["postId" : documentRef.documentID]) { err in
            guard err == nil else {
                return
            }
            self.view.successAddPost()
        }
    }
    
}
