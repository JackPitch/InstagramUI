//
//  User.swift
//  InstagramUI
//
//  Created by Jackson Pitcher on 11/12/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit

struct User {
    let username: String
    let profileImageUrl: String
    let uid: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
