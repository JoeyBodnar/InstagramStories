//
//  StoryView.swift
//  InstagramStoriesTutorial
//
//  Created by Stephen Bodnar on 8/12/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

import UIKit

class StoryView: UIView {
    var imageView = UIImageView()
    var story: Story!
    
    init(story: Story) {
        super.init(frame: CGRect.zero)
        self.story = story
        layoutStory()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func layoutStory() {
        imageView = UIImageView(image: UIImage(named: story.imageName))
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        
        imageView.layer.transform = layer.transform
    }
    
}

