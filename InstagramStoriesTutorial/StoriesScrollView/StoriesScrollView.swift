//
//  StoriesScrollView.swift
//  InstagramStoriesTutorial
//
//  Created by Stephen Bodnar on 8/15/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

import UIKit

protocol StoriesScrollViewDelegate: UIScrollViewDelegate {
    func didSelectItem(in column: Int)
}

class StoriesScrollView: UIScrollView {
    var dataSource = [UIView]()
    
    var storiesDelegate: StoriesScrollViewDelegate? {
        get { return self.delegate as? StoriesScrollViewDelegate }
        set { self.delegate = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        isPagingEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func viewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        for index  in 0..<dataSource.count {
            let view = dataSource[index]
            if view.frame.contains((tapRecognizer.location(in: self))) {
                storiesDelegate?.didSelectItem(in: index)
            }
        }
    }
    
    func setDataSource(with stories: [UIImageView]) {
        dataSource = stories
        for i in 0..<stories.count {
            let story = stories[i]
            let width = frame.width
            let height = frame.height
            let xOffset = width * CGFloat(i)
            story.frame = CGRect(x: xOffset, y: 0, width: width, height: height)
            addSubview(story)
            contentSize = CGSize(width: xOffset + width, height: height)
        }
    }
    
    func visibleViews() -> [UIView] {
        let visibleRect = CGRect(x: contentOffset.x, y: 0, width: frame.width, height: frame.height)
        var views = [UIView]()
        for view  in dataSource{
            if view.frame.intersects(visibleRect) { views.append(view) }
        }
        return views
    }
    
}

