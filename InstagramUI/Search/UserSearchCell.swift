//
//  UserSearchCell.swift
//  InstagramUI
//
//  Created by Jackson Pitcher on 11/16/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit

class UserSearchCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            usernameLabel.text = user?.username
            
            guard let profileImagUrl = user?.profileImageUrl else { return }
            
            profileImageView.loadImage(urlString: profileImagUrl)
        }
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, bottom: nil, left: leftAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 8, paddingRight: 0, width: 50, height: 50)
        
        let separatorView = UIView()
        addSubview(separatorView)
        separatorView.anchor(top: nil, bottom: bottomAnchor, left: usernameLabel.leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0.5)
        
        separatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 8, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
