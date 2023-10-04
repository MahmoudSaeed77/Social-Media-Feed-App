//
//  TimeLineModel.swift
//  SM Feed
//
//  Created by imac on 04/10/2023.
//

import Foundation
import FirebaseFirestore

struct TimeLineModel: Codable {
    var caption, imageUrl, uid, postId: String?
    var date: Date?
    var user: UserModel?
}
