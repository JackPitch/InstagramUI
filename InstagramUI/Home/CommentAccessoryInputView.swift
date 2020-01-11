//
//  CommentAccessoryInputView.swift
//  InstagramUI
//
//  Created by Jackson Pitcher on 12/2/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit
import Firebase

protocol DidTapSubmitDelegate {
    func didSubmit(for comment: String)
}

class CommentAccessoryInputView: UIView {
    
    let commentTextView: CommentInputTextView = {
        let tv = CommentInputTextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.boldSystemFont(ofSize: 18)
        return tv
    }()
    
    let lineSeparatorView: UIView = {   
        let line = UIView()
        line.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return line
    }()
    
    let submitButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.setTitle("Submit", for: .normal)
        sb.setTitleColor(.black, for: .normal)
        sb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        sb.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return sb
    }()
    
    @objc func handleSubmit() {
        print("handling submit")
        guard let text = commentTextView.text else { return }
        delegate?.didSubmit(for: text)
    }
    
    func clearCommentTextField() {
        commentTextView.text = nil
        commentTextView.showPlaceHolderLabel()
    }
    
    var delegate: DidTapSubmitDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        backgroundColor = .white
        
        addSubview(submitButton)
        submitButton.anchor(top: topAnchor, bottom: nil, left: nil, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 12, width: 50, height: 0)
        
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, left: leftAnchor, right: submitButton.leftAnchor, paddingTop: 8, paddingBottom: 8, paddingLeft: 8, paddingRight: 0, width: 0, height: 0)
        
        addSubview(lineSeparatorView)
        lineSeparatorView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
