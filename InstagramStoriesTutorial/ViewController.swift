//
//  ViewController.swift
//  InstagramStoriesTutorial
//
//  Created by Stephen Bodnar on 8/15/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var scrollView = StoriesScrollView()
    var storyView1 = UIImageView(image: UIImage(named: "cat"))
    var storyView2 = UIImageView(image: UIImage(named: "bangkok1"))
    var storyView3 = UIImageView(image: UIImage(named: "bangkok3"))
    var storyView4 = UIImageView(image: UIImage(named: "bangkok7"))
    var storyView5 = UIImageView(image: UIImage(named: "bangkok2"))
    var storyView6 = UIImageView(image: UIImage(named: "bangkok4"))
    var storyView7 = UIImageView(image: UIImage(named: "cat"))
    var storyView8 = UIImageView(image: UIImage(named: "bangkok5"))
    var storyView9 = UIImageView(image: UIImage(named: "bangkok6"))
    
    let leftSideOriginalTransform = CGFloat(90 * Double.pi / 180.0)
    let rightSideCellOriginalTransform = -CGFloat(90 * Double.pi / 180.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        layout()
    }
    
    func layout() {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.setDataSource(with: [storyView1, storyView2, storyView3, storyView4, storyView5, storyView6, storyView7, storyView8, storyView9])
    }
}

extension ViewController: StoriesScrollViewDelegate {
    
    func didSelectItem(in column: Int) {
        if column < (scrollView.dataSource.count - 1) {
            let nextStory = scrollView.dataSource[column + 1]
            let nextOffset = nextStory.frame.origin.x
            scrollView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleViews = self.scrollView.visibleViews().sorted(by: {$0.frame.origin.x > $1.frame.origin.x} )
        let xOffset = scrollView.contentOffset.x
        
        let rightCellAnchorPoint = CGPoint(x: 0, y: 0.5)
        let leftCellAnchorPoint = CGPoint(x: 1, y: 0.5)
        
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / 1000
        
        if let viewFurthestRight = visibleViews.first, let viewFurthestLeft =  visibleViews.last {
            let hasCompletedPaging = (xOffset / viewWidth).truncatingRemainder(dividingBy: 1) == 0
            var rightAnimationPercentComplete = hasCompletedPaging ? 0 :1 - (xOffset / viewWidth).truncatingRemainder(dividingBy: 1)
            if xOffset < 0 { rightAnimationPercentComplete -= 1 }
            viewFurthestRight.transform(to: rightSideCellOriginalTransform * rightAnimationPercentComplete, with: transform)
            viewFurthestRight.setAnchorPoint(rightCellAnchorPoint)
            
            if  xOffset > 0 {
                let leftAnimationPercentComplete = (xOffset / scrollView.frame.width).truncatingRemainder(dividingBy: 1)
                viewFurthestLeft.transform(to: leftSideOriginalTransform * leftAnimationPercentComplete, with: transform)
                viewFurthestLeft.setAnchorPoint(leftCellAnchorPoint)
            }
        }
    }
    
}

extension UIView {
    
    func transform(to radians: CGFloat, with transform: CATransform3D) {
        layer.transform = CATransform3DRotate(transform, radians, 0, 1, 0.0)
    }
    
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
}
