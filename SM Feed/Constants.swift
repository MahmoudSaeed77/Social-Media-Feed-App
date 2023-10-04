//
//  Contants.swift
//  SM Feed
//
//  Created by imac on 03/10/2023.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
struct Constants {
    
    public static let storageRef = Storage.storage().reference()
    public static let databaseRef = Firestore.firestore()
    
    
}
