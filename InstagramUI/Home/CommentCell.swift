//
//  CommentCell.swift
//  InstagramUI
//
//  Created by Jackson Pitcher on 11/25/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {

    var comment: Comment? {
        didSet {
            guard let comment = comment else { return }
            
            let attributedText = NSMutableAttributedString(string: comment.user.username, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: " " + comment.text, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
            
            textView.text = comment.text
            profileImageView.loadImage(urlString: comment.user.profileImageUrl)
        }
    }

    let textView: UITextView = {
        let label = UITextView()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = .lightGray
        label.isScrollEnabled = false
        return label
    }()
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, paddingTop: 8, paddingBottom: 0, paddingLeft: 8, paddingRight: 0, width: 40, height: 40)
        profileImageView.layer.cornerRadius = 40 / 2

        addSubview(textView)
        textView.anchor(top: topAnchor, bottom: bottomAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 4, paddingBottom: 4, paddingLeft: 4, paddingRight: 4, width: 0, height: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
