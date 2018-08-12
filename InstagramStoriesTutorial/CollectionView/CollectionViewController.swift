//
//  CollectionViewController.swift
//  InstagramStoriesTutorial
//
//  Created by Stephen Bodnar on 8/12/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    var collectionView: UICollectionView!
    var stories = [Story(username: "misty", imageName: "me"), Story(username: "joey", imageName: "me"), Story(username: "natthanicha", imageName: "cat"), Story(username: "stephen", imageName: "me"), Story(username: "allen", imageName: "cat")]
    
    var lastXOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    func layout() {
        let layout = StoriesLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: "StoryCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as? StoryCell {
            cell.setup(with: stories[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CollectionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentXOffset = scrollView.contentOffset.x
         let pageNumber = Int(currentXOffset / 320)
        
        if currentXOffset > lastXOffset {
            // scrolling right
            let cells = collectionView.visibleCells
            if cells.count == 1 { return }
            var transform = CATransform3DIdentity
            transform.m34 = 1.0 / 1000
           
            
            
            if let lastCell = cells.sorted(by: {$0.frame.origin.x > $1.frame.origin.x} ).first, let firstCell =  cells.sorted(by: {$0.frame.origin.x > $1.frame.origin.x} ).last {
                
                let rightSideCellOriginalTransform = -CGFloat(90 * M_PI / 180.0)
                var factor = 1 - abs(CGFloat(pageNumber) - (currentXOffset / 320))
                if factor == 1 { factor = 0 } 
                // last cell (on right)
                lastCell.contentView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
                lastCell.contentView.center = CGPoint(x: 0, y: view.frame.height / 2)
                lastCell.contentView.layer.transform = CATransform3DRotate(transform, rightSideCellOriginalTransform * factor, 0, 1, 0.0)
                
                // first cell (on left)
                firstCell.contentView.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
                firstCell.contentView.center = CGPoint(x: view.frame.width, y: view.frame.height / 2)
                let originalTransform3 = CGFloat(90 * M_PI / 180.0)
                let factor2 = pageNumber > 0 ? abs(CGFloat(pageNumber) - ((currentXOffset / 320))) : (currentXOffset / 320)
                firstCell.contentView.layer.transform = CATransform3DRotate(transform, originalTransform3 * factor2, 0, 1, 0.0)
                
                if let cell = lastCell as? StoryCell { cell.shadowView.alpha = factor * 0.75 }
            
            }
        } else {
            let cells = collectionView.visibleCells
            if cells.count == 1 { return }
            if let firstCell = cells.sorted(by: {$0.frame.origin.x > $1.frame.origin.x} ).last, let lastCell = cells.sorted(by: {$0.frame.origin.x > $1.frame.origin.x} ).first {
                var transform = CATransform3DIdentity
                transform.m34 = 1.0 / 1000
                
                // first cell (on left)
                firstCell.contentView.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
                firstCell.contentView.center = CGPoint(x: view.frame.width, y: view.frame.height / 2)
                
                let originalTransform = CGFloat(90 * M_PI / 180.0)
                let factor2 = abs(CGFloat(320 * pageNumber) - currentXOffset) / 320
                firstCell.contentView.layer.transform = CATransform3DRotate(transform, originalTransform * factor2, 0, 1, 0.0)
                
                // last cell (on right)
                lastCell.contentView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
                lastCell.contentView.center = CGPoint(x: 0, y: view.frame.height / 2)
                
                let originalTransform2 = -CGFloat(90 * M_PI / 180.0)
                let factor = 1 - abs(CGFloat(pageNumber) * 320 - currentXOffset) / 320
                lastCell.contentView.layer.transform = CATransform3DRotate(transform, originalTransform2 * factor, 0, 1, 0.0)
            }
        }
        lastXOffset = scrollView.contentOffset.x
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
}
