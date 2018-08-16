//
//  NewViewController.swift
//  InstagramStoriesTutorial
//
//  Created by Stephen Bodnar on 8/16/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var scrollView = StoriesScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    func layout() {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        let story1 = UIView()
        story1.backgroundColor = UIColor.orange
        let story2 = UIView()
        story2.backgroundColor = UIColor.red
        let story3 = UIView()
        story3.backgroundColor = UIColor.blue
        let story4 = UIView()
        story4.backgroundColor = UIColor.green
        scrollView.setDataSource(with: [story2, story1, story3, story4])    
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleViews = self.scrollView.visibleViews().sorted(by: {$0.frame.origin.x > $1.frame.origin.x} ) // 1
        let xOffset = scrollView.contentOffset.x // 2
        
        // 3
        let rightViewAnchorPoint = CGPoint(x: 0, y: 0.5)
        let leftViewAnchorPoint = CGPoint(x: 1, y: 0.5)
        
        // 4
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / 1000
        
        // 5
        let leftSideOriginalTransform = CGFloat(90 * Double.pi / 180.0)
        let rightSideCellOriginalTransform = -CGFloat(90 * Double.pi / 180.0)
        
        if let viewFurthestRight = visibleViews.first, let viewFurthestLeft =  visibleViews.last {
            let hasCompletedPaging = (xOffset / scrollView.frame.width).truncatingRemainder(dividingBy: 1) == 0
            var rightAnimationPercentComplete = hasCompletedPaging ? 0 :1 - (xOffset / scrollView.frame.width).truncatingRemainder(dividingBy: 1)

            if xOffset < 0 { rightAnimationPercentComplete -= 1 }
            viewFurthestRight.transform(to: rightSideCellOriginalTransform * rightAnimationPercentComplete, with: transform)
            viewFurthestRight.setAnchorPoint(rightViewAnchorPoint)
            
              if  xOffset > 0 {
                let leftAnimationPercentComplete = (xOffset / scrollView.frame.width).truncatingRemainder(dividingBy: 1)
                viewFurthestLeft.transform(to: leftSideOriginalTransform * leftAnimationPercentComplete, with: transform)
                viewFurthestLeft.setAnchorPoint(leftViewAnchorPoint)
               }
        }
    }
}
