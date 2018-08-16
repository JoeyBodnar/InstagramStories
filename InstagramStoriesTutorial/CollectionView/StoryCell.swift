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
    var story: Story!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout(with: frame)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        storyImageView.image = nil
    //    shadowView.alpha = 0
        usernameLabel.text = nil
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(with story: Story) {
        self.story = story
        storyImageView.image = UIImage(named: story.imageName)
        usernameLabel.text = story.username
        contentView.layer.contents = UIImage(named: story.imageName)?.cgImage
      //  layer.contents = UIImage(named: story.imageName)?.cgImage
    }
}

extension StoryCell {
    func layout(with frame: CGRect) {
        // story image view
        storyImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        contentView.addSubview(storyImageView)
        
        usernameLabel.frame = CGRect(x: 30, y: 30, width: 200, height: 19)
        contentView.addSubview(usernameLabel)
        
        usernameLabel.textColor = UIColor.white
        usernameLabel.layer.shadowColor = UIColor.black.cgColor
        usernameLabel.layer.shadowOpacity = 1
        usernameLabel.layer.shadowRadius = 1
        usernameLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        usernameLabel.font = UIFont(name: "Avenir Next", size: 21)
        
        // shadow view
       /* shadowView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shadowView)
        shadowView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        shadowView.backgroundColor = UIColor.black
        shadowView.alpha = 0 */
        
    }
}
