//
//  CommentInputTextView.swift
//  InstagramUI
//
//  Created by Jackson Pitcher on 12/2/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit

class CommentInputTextView: UITextView {
    
    let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Comment"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    func showPlaceHolderLabel() {
        placeHolderLabel.isHidden = false
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
        
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingBottom: 0, paddingLeft: 8, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func handleTextChange() {
        placeHolderLabel.isHidden = !self.text.isEmpty
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
