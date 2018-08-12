//
//  StoryCell.swift
//  InstagramStoriesTutorial
//
//  Created by Stephen Bodnar on 8/12/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {
    var storyImageView = UIImageView()
    var shadowView = UIView()
    var usernameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        storyImageView.image = nil
        shadowView.alpha = 0
        usernameLabel.text = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(with story: Story) {
        storyImageView.image = UIImage(named: story.imageName)
        usernameLabel.text = story.username
    }
}

extension StoryCell {
    func layout() {
        // story image view
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(storyImageView)
        storyImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        storyImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        storyImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        storyImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        storyImageView.contentMode = UIViewContentMode.scaleAspectFill
        storyImageView.clipsToBounds = true
        storyImageView.layer.masksToBounds = true
        
        // username label
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(usernameLabel)
        usernameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        usernameLabel.textColor = UIColor.white
        usernameLabel.layer.shadowColor = UIColor.black.cgColor
        usernameLabel.layer.shadowOpacity = 1
        usernameLabel.layer.shadowRadius = 1
        usernameLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        usernameLabel.font = UIFont(name: "Avenir Next", size: 21)
        
        // shadow view
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shadowView)
        shadowView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        shadowView.backgroundColor = UIColor.black
        shadowView.alpha = 0
        
    }
}
