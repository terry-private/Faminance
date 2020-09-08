//
//  User.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation
import Firebase
class User {
    let id: String
    let name: String
    let email: String
    var profileImageURL: String = ""
    var createdAt = Date.current
    
    init(dic: [String: Any]) {
        id = dic["id"] as? String ?? "noId"
        name = dic["name"] as? String ?? ""
        email = dic["mail"] as? String ?? ""
        profileImageURL = dic["profileImageURL"] as? String ?? ""
        createdAt = (dic["createdAt"] as? Timestamp)?.dateValue().added(hour: 9) ?? Date.current
    }
}
