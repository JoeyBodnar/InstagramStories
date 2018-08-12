//
//  ViewController.swift
//  InstagramStoriesTutorial
//
//  Created by Stephen Bodnar on 8/11/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var scrollView = StoriesScrollView()
    var storyView1 = StoryView(story: Story(username: "stephen", imageName: "me"))
    var storyView2 = StoryView(story: Story(username: "natthanicha", imageName: "cat"))
    var storyView3 = StoryView(story: Story(username: "allen", imageName: "me"))
    
    var lastStoppedOffset = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        layout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func layout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.backgroundColor = UIColor.clear
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        let width = view.frame.width
        let height = view.frame.height
        storyView1.frame  = CGRect(x: 0, y: 0, width: width, height: height)
        storyView2.frame = CGRect(x: width, y: 0, width: width, height: height)
        storyView3.frame = CGRect(x: width * 2, y: 0, width: width, height: height)
        
        storyView1.backgroundColor = UIColor.green
        storyView2.backgroundColor = UIColor.yellow
        storyView3.backgroundColor = UIColor.orange
        
       scrollView.addSubview(storyView1)
        scrollView.addSubview(storyView2)
        scrollView.addSubview(storyView3)
        
        scrollView.contentSize = CGSize(width: width * 3, height: height)
        scrollView.setContentOffset(CGPoint(x: width, y: 0), animated: false)
        
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / 1000
        
        // for initial state
        storyView1.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
        storyView1.center = CGPoint(x: view.frame.width, y: view.frame.height / 2)
        transform = CATransform3DRotate(transform, CGFloat(85.0 * M_PI / 180.0), 0, 1, 0.0)
        storyView1.layer.transform = transform
        
        var transform2 = CATransform3DIdentity
        transform2.m34 = 1.0 / 1000
        
        storyView3.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        storyView3.center = CGPoint(x: view.frame.width * 2, y: view.frame.height / 2)
        transform2 = CATransform3DRotate(transform2, -CGFloat(85 * M_PI / 180.0), 0, 1, 0.0)
        storyView3.layer.transform = transform2
        
    }

}

extension ViewController: UIScrollViewDelegate {
    
   func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        // Call your function here
        print("stopped")
        
        lastStoppedOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(UIScrollViewDelegate.scrollViewDidEndScrollingAnimation), with: nil, afterDelay: 0.15)
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / 1000
        
        let currentXOffset = scrollView.contentOffset.x
        let originalTransform = CGFloat(85.0 * M_PI / 180.0)
        storyView1.layer.transform = CATransform3DRotate(transform, originalTransform * (currentXOffset / 320), 0, 1, 0.0)
        
        
        
        // right side
        let originalTransform2 = -CGFloat(85 * M_PI / 180.0)
        let factor = 1 - ((currentXOffset / 320) - 1)
        storyView3.layer.transform = CATransform3DRotate(transform, originalTransform2 * factor, 0, 1, 0.0)
    }
}
