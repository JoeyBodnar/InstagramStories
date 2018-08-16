//
//  Extensions.swift
//  InstagramStoriesTutorial
//
//  Created by Stephen Bodnar on 8/16/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

import UIKit

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
