//
//  SharePhotoController.swift
//  InstagramUI
//
//  Created by Jackson Pitcher on 11/7/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    fileprivate func setupImageAndTextViews() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: containerView.leftAnchor, right: nil, paddingTop: 8, paddingBottom: 8, paddingLeft: 8, paddingRight: 0, width: 84, height: 0)
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: imageView.rightAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 4, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func handleShare() {
        guard let caption = textView.text, caption.count > 0 else { return }

        guard let image = selectedImage else { return }

        guard let uploadData = image.jpegData(compressionQuality: 0.5) else { return }

        navigationItem.rightBarButtonItem?.isEnabled = false

        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(filename)
        storageRef.putData(uploadData, metadata: nil) { (metadata, err) in
            if let err = err {
                print("Error uploading post image, ", err)
            }

            storageRef.downloadURL { (url, err) in
                guard let imageUrl = url?.absoluteString else { return }
                print("Successfully uploaded post image", imageUrl)
                self.saveToDatabaseWithImageUrl(imageUrl: imageUrl)
            }
        }
    }
    

    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String) {
        guard let caption = textView.text, caption.count > 0 else { return }
        guard let postImage = selectedImage else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let ref = Database.database().reference().child("posts").child(uid).childByAutoId()
        let values = ["caption": caption, "imageUrl": imageUrl, "imageHeight": postImage.size.height, "imageWidth": postImage.size.width, "creationDate": Date().timeIntervalSince1970] as [String:Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("error uploading photo to database, ", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            print("Successfully saved to database")
            
            self.dismiss(animated: true, completion: nil)
            
            let name = NSNotification.Name(rawValue: "updateFeed")

            NotificationCenter.default.post(name: name, object: nil)
        }
    }


    override var prefersStatusBarHidden: Bool {
        return true
    }
}
