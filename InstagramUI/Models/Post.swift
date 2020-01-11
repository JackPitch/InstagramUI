//
//  File.swift
//  InstagramUI
//
//  Created by Jackson Pitcher on 11/9/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import Foundation

struct Post {
    
    var id: String?
    
    let imageUrl: String
    let user: User
    let caption: String
    let creationDate: Date
    
    var hasLiked: Bool = false
    
    init(user: User, dictionary: [String:Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
