//
//  CollectionViewController.swift
//  InstagramStoriesTutorial
//
//  Created by Stephen Bodnar on 8/12/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

enum ScrollDirection {
    case left
    case right
    
    var description: String {
        switch self {
        case .left: return "left"
        case .right: return "right"
        }
    }
}

import UIKit

class CollectionViewController: UIViewController {
    fileprivate let maxAngle: CGFloat = 60.0
    var collectionView: UICollectionView!
    var stories = [Story(username: "misty", imageName: "me"), Story(username: "Bangkok1", imageName: "bangkok1"), Story(username: "natthanicha", imageName: "cat"), Story(username: "Bangkok2", imageName: "bangkok7"), Story(username: "allen", imageName: "bangkok2"), Story(username: "misty", imageName: "me"), Story(username: "Bangkok1", imageName: "bangkok1"), Story(username: "natthanicha", imageName: "bangkok3"), Story(username: "Bangkok2", imageName: "bangkok2"), Story(username: "allen", imageName: "cat"), Story(username: "misty", imageName: "bangkok4"), Story(username: "Bangkok1", imageName: "bangkok5"), Story(username: "natthanicha", imageName: "bangkok6"), Story(username: "Bangkok2", imageName: "bangkok7"), Story(username: "allen", imageName: "cat")]
    
    var lastXOffset: CGFloat = 0
    var lastScrollViewCaptureTime = Date().timeIntervalSinceReferenceDate
    
    let leftSideOriginalTransform = CGFloat(90 * Double.pi / 180.0)
    let rightSideCellOriginalTransform = -CGFloat(90 * Double.pi / 180.0)
    var lastScrollDirection = ScrollDirection.right
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
}

extension CollectionViewController: UIScrollViewDelegate {

    fileprivate func setAnchorPoint(_ anchorPoint: CGPoint, forView view: UIView) {
        
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
        print("the view anchor point is \(anchorPoint)")
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        transformViewsInScrollView(scrollView)
       /* let currentXOffset = scrollView.contentOffset.x
        let now = Date().timeIntervalSinceReferenceDate
        let difference = now - lastScrollViewCaptureTime
        let distance = currentXOffset - lastXOffset
        let speed = distance / CGFloat(difference)
        let xOffsetDifference = abs(currentXOffset - lastXOffset)
      //  print("the difference between xOffsets is \(xOffsetDifference)")
        print("current x offset is \(currentXOffset) and the difference is \(xOffsetDifference)")
        let e = scrollView.panGestureRecognizer.velocity(in: view)
        lastScrollDirection = e.x > 0 ? ScrollDirection.right : e.x < 0 ? ScrollDirection.left :  lastScrollDirection
        
        let pageNumber = Int(currentXOffset / viewWidth)
        let cells = collectionView.visibleCells.sorted(by: {$0.frame.origin.x > $1.frame.origin.x} )
        
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / 1000
        
        let rightCellAnchorPoint = CGPoint(x: 0, y: 0.5)
        let leftCellAnchorPoint = CGPoint(x: 1, y: 0.5)
        
        if cells.count <= 1 {
            print("cell count is 1")
            return
        }
        if lastScrollDirection == .left {
            if let cellFurthestRight = cells.first as? StoryCell, let cellFurthestLeft =  cells.last as? StoryCell {
                var percentDone = 1 - abs(CGFloat(pageNumber) - (currentXOffset / viewWidth))
                for x in cells {
                    let rect = self.collectionView.convert(x.frame, to: view)
                    if (rect.origin.x > (-viewWidth / 2)) && rect.origin.x < (viewWidth / 2)  {
                        if (percentDone > 0.98 || percentDone < 0.04 || xOffsetDifference > 45) {
                            let cellz = x as! StoryCell
                            cellz.layer.contents = UIImage(named: cellz.story.imageName)?.cgImage
                           
                        }  else if xOffsetDifference > 50 {
                            let cellz = x as! StoryCell
                            cellz.layer.contents = UIImage(named: cellz.story.imageName)?.cgImage
                        } else { x.layer.contents = nil }
                    } else {
                        x.layer.contents = nil
                    }
                }
                if percentDone == 1 { percentDone = 0 }
                cellFurthestRight.contentView.layer.transform = CATransform3DRotate(transform, rightSideCellOriginalTransform * percentDone, 0, 1, 0.0)
                setAnchorPoint(rightCellAnchorPoint, forView: cellFurthestRight.contentView)
                cellFurthestRight.contentView.center = CGPoint(x: 0, y: view.frame.height / 2)
                
                // first cell (on left)
                let leftAnimationPercentDone = pageNumber > 0 ? abs(CGFloat(pageNumber) - ((currentXOffset / viewWidth))) : (currentXOffset / viewWidth)
                cellFurthestLeft.contentView.layer.transform = CATransform3DRotate(transform, leftSideOriginalTransform * leftAnimationPercentDone, 0, 1, 0.0)
                setAnchorPoint(leftCellAnchorPoint, forView: cellFurthestLeft.contentView)
                cellFurthestLeft.contentView.center = CGPoint(x: view.frame.width, y: view.frame.height / 2)
                
            }
        } else if lastScrollDirection == .right {
            let firstCellMultiplicationFactor = abs(CGFloat(viewWidth * CGFloat(pageNumber)) - currentXOffset) / viewWidth
            let rightCellMultiplicationFactor = 1 - abs(CGFloat(pageNumber) * viewWidth - currentXOffset) / viewWidth
            
            for x in cells {
                let rect = self.collectionView.convert(x.frame, to: view)
                if (rect.origin.x > (-viewWidth / 2)) && rect.origin.x < (viewWidth / 2)  {
                    if rightCellMultiplicationFactor > 0.98 || rightCellMultiplicationFactor < 0.02 {
                        let cellz = x as! StoryCell
                        cellz.layer.contents = UIImage(named: cellz.story.imageName)?.cgImage
                    } else { x.layer.contents = nil }
                } else {
                    x.layer.contents = nil
                }
            }
            
            if let cellFurthestLeft = cells.last as? StoryCell, let cellFurthestRight = cells.first as? StoryCell {
                // first cell (on left)
                cellFurthestLeft.contentView.layer.anchorPoint = leftCellAnchorPoint
                cellFurthestLeft.contentView.center = CGPoint(x: view.frame.width, y: view.frame.height / 2)
                cellFurthestLeft.contentView.layer.transform = CATransform3DRotate(transform, leftSideOriginalTransform * firstCellMultiplicationFactor, 0, 1, 0.0)
                
                // last cell (on right)
                cellFurthestRight.contentView.layer.anchorPoint = rightCellAnchorPoint
                cellFurthestRight.contentView.center = CGPoint(x: 0, y: view.frame.height / 2)
                cellFurthestRight.contentView.layer.transform = CATransform3DRotate(transform, rightSideCellOriginalTransform * rightCellMultiplicationFactor, 0, 1, 0.0)
            
                cellFurthestLeft.shadowView.alpha = 0
                cellFurthestRight.shadowView.alpha = 0
            }
        }
        lastXOffset = scrollView.contentOffset.x
        lastScrollViewCaptureTime = Date().timeIntervalSinceReferenceDate
 */
    }
    
    fileprivate func transformViewsInScrollView(_ scrollView: UIScrollView) {
        
        let xOffset = scrollView.contentOffset.x
        let svWidth = scrollView.frame.width
        var deg = maxAngle / scrollView.bounds.size.width * xOffset
        let childViews = collectionView.visibleCells.map { (cell) -> UIView in
            return cell.contentView
        }
        
        for index in 0 ..< childViews.count {
            
            let view = childViews[index]
            
            deg = index == 0 ? deg : deg - maxAngle
            if index == 0 { print("the degree is \(deg)") }
            
            let rad = deg * CGFloat(Double.pi / 180)
            var transform = CATransform3DIdentity
            transform.m34 = 1 / 500
            transform = CATransform3DRotate(transform, rad, 0, 1, 0)
            
            view.layer.transform = transform
            
            let x = xOffset / svWidth > CGFloat(index) ? 1 : 0.0
            setAnchorPoint(CGPoint(x: x, y: 0.5), forView: view)
            
        //    applyShadowForView(view, index: index)
        }
    }

}

extension CollectionViewController {
    func layout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        collectionView.backgroundColor = UIColor.white
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: "StoryCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}
