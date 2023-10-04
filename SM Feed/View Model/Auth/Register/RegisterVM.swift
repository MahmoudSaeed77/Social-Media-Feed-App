//
//  RegisterVM.swift
//  SM Feed
//
//  Created by imac on 03/10/2023.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class RegisterVM {
    
    private weak var view: RegisterVC!
    
    
    
    init(view: RegisterVC) {
        self.view = view
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            guard err == nil else {
                return
            }
            
            guard let user = result?.user else {
                return
            }
            
            self.storeUserImage(uid: user.uid)
        }
    }
    
    func storeUserImage(uid: String) {
        guard let imageData = self.view.profileImgView.image?.jpegData(compressionQuality: 0.4) else {return}
        let imageRef = Constants.storageRef.child("Users").child(uid).child("\(uid).jpg")
        Task {
            try? await imageRef.delete()
        }
        imageRef.putData(imageData, metadata: nil) { metadata, err in
            guard self.view != nil else {return}
            guard err == nil else {
                self.storeUserData(nil)
                return
            }
            imageRef.downloadURL(completion: { url, err in
                guard err == nil else {
                    self.storeUserData(nil)
                    return
                }
                guard let imageUrl = url?.absoluteString else {
                    self.storeUserData(nil)
                    return
                }
                self.storeUserData(imageUrl)
            })
        }
    }
    
    func storeUserData(_ profileImageUrl: String?) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data: [String:String] = [
            "username": self.view.usernameField.text ?? "",
            "email": self.view.emailField.text ?? "",
            "profileImageUrl": profileImageUrl ?? "",
            "gender": "\(self.view.genderSegment.selectedSegmentIndex)",
            "uid": uid
        ]
        Constants.databaseRef.collection("Users").document(uid).setData(data) { err in
            guard err == nil else {
                return
            }
            
            self.view.navigateToHomeController()
        }
    }
}
