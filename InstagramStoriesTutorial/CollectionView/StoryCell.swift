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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        storyImageView.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(with story: Story) {
        storyImageView.image = UIImage(named: story.imageName)
    }
}

extension StoryCell {
    func layout() {
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(storyImageView)
        
        storyImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        storyImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        storyImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        storyImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        storyImageView.contentMode = UIViewContentMode.scaleAspectFill
        storyImageView.clipsToBounds = true
        storyImageView.layer.masksToBounds = true
        
        storyImageView.image = UIImage(named: "me")
        
      //  imageView.layer.transform = layer.transform
    }
}
