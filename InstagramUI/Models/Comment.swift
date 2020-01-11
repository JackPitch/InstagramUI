//
//  Comment.swift
//  InstagramUI
//
//  Created by Jackson Pitcher on 11/25/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit

struct Comment {
    let text: String
    let uid: String
    
    let user: User
    
    init(user: User, dictionary: [String:Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
