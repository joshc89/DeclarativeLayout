//
//  ParallaxScrollLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// `Layout` for a background `Layout` that moves with a parallax scroll effect behind another `Layout`.
public class ParallaxScrollLayout: NSObject, Layout {
    
    public let backgroundLayout:Layout
    public let foregroundLayout:Layout
    
    public let scrollView = UIScrollView()
    
    var connectingConstraint: NSLayoutConstraint?
    
    public var bouncesHeader: Bool = false {
        didSet {
            if bouncesHeader != oldValue {
                scrollViewDidScroll(scrollView)
            }
        }
    }
    
    public var scrollRate: CGFloat = 0.5 {
        didSet {
            if scrollRate != oldValue {
                // recalculate the offset
                self.scrollViewDidScroll(scrollView)
            }
        }
    }
    
    public init(backgroundLayout: Layout, foregroundLayout: Layout) {
        
        self.backgroundLayout = backgroundLayout
        self.foregroundLayout = foregroundLayout
        
        scrollView.addLayout(backgroundLayout)
        scrollView.addLayout(foregroundLayout)
        
        scrollView.alwaysBounceVertical = true
        
        // constrain the content width to be that of the scroll view 
        scrollView.widthAnchor.constraintEqualToAnchor(foregroundLayout.boundary.widthAnchor).active = true
        
        super.init()
        
        // observe the offset to perform the scroll
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: [.Old, .New], context: nil)
    }
    
    deinit {
        scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    // MARK: Parallax Scroll Methods
    
    /// Responds to observing the `contentOffset` of `scrollView` and `frame` changes of `backgroundLayout`.
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if let sv = object as? UIScrollView
            where keyPath == "contentOffset" {
            scrollViewDidScroll(sv)
        }
    }
    
    
    /// Implements the parallax scroll view by adjusting the constraint aligning the `backgroundLayout` top with `boundary`.
    public func scrollViewDidScroll(scrollView:UIScrollView) {
        
        // implement parallax
        let offset = scrollView.contentOffset.y + scrollView.contentInset.top
        let parallax = floor(scrollRate * offset)
        
        // TODO: fix bounce at bottom
//        let maximumParallax = ...
        let foregroundTop = max(0, parallax)
        
        if connectingConstraint?.constant != foregroundTop {
            connectingConstraint?.constant = foregroundTop
        }
        
        if let view = backgroundLayout as? UIView
            where !bouncesHeader {
            
            let bouncing = scrollView.contentOffset.y < -scrollView.contentInset.top
            let bounceOffset = scrollView.contentOffset.y + scrollView.contentInset.top
            let transform = bouncing ? CGAffineTransformMakeTranslation(0, bounceOffset) : CGAffineTransformIdentity
            
            if !CGAffineTransformEqualToTransform(view.transform, transform) {
                view.transform = transform
            }
        }
    }
    
    // MARK: Layout Conformance
    
    /// - returns: The containing `boundary` UILayoutGuide, `backgroundLayout` and `scrollView`.
    public var elements: [Layout] {
        return [scrollView]
    }
    
    /// A UILayoutGuide aligning the `backgroundLayout` and `scrollView`.
    public var boundary: AnchoredObject {
        return scrollView
    }
    
    /// - returns: Constraints aligning `backgroundLayout` and `foregroundLayout` within `scrollView`.
    public func generateConstraints() -> [NSLayoutConstraint] {
        
        let backgroundEdges = backgroundLayout.boundary.constraintsAligningEdgesTo(scrollView)
        
        let foregroundEdges = foregroundLayout.boundary.constraintsAligningEdgesTo(scrollView)
        
        let connecting = backgroundLayout.boundary.bottomAnchor.constraintEqualToAnchor(foregroundLayout.boundary.topAnchor)
        connectingConstraint = connecting
        
        return [backgroundEdges[0], backgroundEdges[1], backgroundEdges[3], connecting] + foregroundEdges[1...3]
    }
}