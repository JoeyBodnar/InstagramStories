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
    var stories = [Story(username: "misty", imageName: "me"), Story(username: "Bangkok1", imageName: "bangkok1"), Story(username: "natthanicha", imageName: "cat"), Story(username: "Bangkok2", imageName: "bangkok2"), Story(username: "allen", imageName: "cat"), Story(username: "misty", imageName: "me"), Story(username: "Bangkok1", imageName: "bangkok1"), Story(username: "natthanicha", imageName: "cat"), Story(username: "Bangkok2", imageName: "bangkok2"), Story(username: "allen", imageName: "cat"), Story(username: "misty", imageName: "me"), Story(username: "Bangkok1", imageName: "bangkok1"), Story(username: "natthanicha", imageName: "cat"), Story(username: "Bangkok2", imageName: "bangkok2"), Story(username: "allen", imageName: "cat")]
    
    var lastXOffset: CGFloat = 0
    
    let leftSideOriginalTransform = CGFloat(90 * Double.pi / 180.0)
    let rightSideCellOriginalTransform = -CGFloat(90 * Double.pi / 180.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    func layout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: "StoryCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CollectionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentXOffset = scrollView.contentOffset.x
         let pageNumber = Int(currentXOffset / viewWidth)
        let cells = collectionView.visibleCells.sorted(by: {$0.frame.origin.x > $1.frame.origin.x} )
        if cells.count == 1 || cells.count == 0 { return }
    
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / 900
        
        let rightCellAnchorPoint = CGPoint(x: 0, y: 0.5)
        let leftCellAnchorPoint = CGPoint(x: 1, y: 0.5)
        
        if currentXOffset > lastXOffset {
            // scrolling right
            if let cellFurthestRight = cells.first, let cellFurthestLeft =  cells.last {
                
                var factor = 1 - abs(CGFloat(pageNumber) - (currentXOffset / viewWidth))
                if factor == 1 { factor = 0 } 
                // last cell (on right)
                cellFurthestRight.contentView.layer.anchorPoint = rightCellAnchorPoint
                cellFurthestRight.contentView.center = CGPoint(x: 0, y: view.frame.height / 2)
                cellFurthestRight.contentView.layer.transform = CATransform3DRotate(transform, rightSideCellOriginalTransform * factor, 0, 1, 0.0)
                
                   print(rightSideCellOriginalTransform * factor)
                //   print(lastScrollTime)
                //  print("")
                
                
                
                // first cell (on left)
                cellFurthestLeft.contentView.layer.anchorPoint = leftCellAnchorPoint
                cellFurthestLeft.contentView.center = CGPoint(x: view.frame.width, y: view.frame.height / 2)
                let factor2 = pageNumber > 0 ? abs(CGFloat(pageNumber) - ((currentXOffset / viewWidth))) : (currentXOffset / viewWidth)
                cellFurthestLeft.contentView.layer.transform = CATransform3DRotate(transform, leftSideOriginalTransform * factor2, 0, 1, 0.0)
                
          //      if let cell = cellFurthestRight as? StoryCell { cell.shadowView.alpha = factor > 0.98 ? 0 : factor * 0.75 }
            }
        } else {
            if let cellFurthestLeft = cells.last, let cellFurthestRight = cells.first {
                
                // first cell (on left)
                cellFurthestLeft.contentView.layer.anchorPoint = leftCellAnchorPoint
                cellFurthestLeft.contentView.center = CGPoint(x: view.frame.width, y: view.frame.height / 2)
                let firstCellMultiplicationFactor = abs(CGFloat(viewWidth * CGFloat(pageNumber)) - currentXOffset) / viewWidth
                cellFurthestLeft.contentView.layer.transform = CATransform3DRotate(transform, leftSideOriginalTransform * firstCellMultiplicationFactor, 0, 1, 0.0)
                
                // last cell (on right)
                cellFurthestRight.contentView.layer.anchorPoint = rightCellAnchorPoint
                cellFurthestRight.contentView.center = CGPoint(x: 0, y: view.frame.height / 2)
                let rightCellMultiplicationFactor = 1 - abs(CGFloat(pageNumber) * viewWidth - currentXOffset) / viewWidth
                cellFurthestRight.contentView.layer.transform = CATransform3DRotate(transform, rightSideCellOriginalTransform * rightCellMultiplicationFactor, 0, 1, 0.0)
            }
        }
        lastXOffset = scrollView.contentOffset.x
    }
}

