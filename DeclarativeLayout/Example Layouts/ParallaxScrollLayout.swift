//
//  ParallaxScrollLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// `Layout` for a background `Layout` that moves with a parallax scroll effect behind another `Layout`.
public final class ParallaxScrollLayout: NSObject, Layout {
    
    public let backgroundLayout:Layout
    public let foregroundLayout:Layout
    
    public let scrollView = UIScrollView()
    
    /// Internal variable for the constraint connecting the background and foreground. The constant is adjusted to implement the parallax scroll.
    let connectingConstraint: NSLayoutConstraint
    
    /// Internal variable to give a constant space between the top of the foreground and top of the scroll view content. As the background `Layout` moves, the content size of the scroll view permanently changes. This makes the scrolling stuttered and prevents the view from bouncing.
    let backgroundSpaceGuide: UILayoutGuide
    
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
        
        backgroundSpaceGuide = UILayoutGuide()
        
        // configure the scroll view
        scrollView.addLayout(backgroundLayout)
        scrollView.addLayout(backgroundSpaceGuide)
        scrollView.addLayout(foregroundLayout)
        
        scrollView.alwaysBounceVertical = true
        
        // constrain the scroll view contents
        scrollView.widthAnchor.constraintEqualToAnchor(foregroundLayout.boundary.widthAnchor).active = true
        
        backgroundSpaceGuide.heightAnchor.constraintEqualToAnchor(backgroundLayout.boundary.heightAnchor)
        
        let gTop = backgroundSpaceGuide.topAnchor.constraintEqualToAnchor(scrollView.topAnchor)
        let gBottom = backgroundSpaceGuide.bottomAnchor.constraintEqualToAnchor(foregroundLayout.boundary.topAnchor)
        
        let gLeading = backgroundSpaceGuide.boundary.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor)
        let gTrailing = backgroundSpaceGuide.boundary.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor)
        
        let gHeight = backgroundSpaceGuide.heightAnchor.constraintEqualToAnchor(backgroundLayout.boundary.heightAnchor)
        
        let bLeading = backgroundLayout.boundary.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor)
        let bTrailing = backgroundLayout.boundary.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor)

        connectingConstraint = backgroundLayout.boundary.bottomAnchor.constraintEqualToAnchor(foregroundLayout.boundary.topAnchor)
        
        let fLeading = foregroundLayout.boundary.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor)
        let fTrailing = foregroundLayout.boundary.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor)
        let fBottom = foregroundLayout.boundary.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor)
        
        NSLayoutConstraint.activateConstraints([gTop, gBottom, gLeading, gTrailing, gHeight, bLeading, bTrailing, connectingConstraint, fLeading, fTrailing, fBottom])
        
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
        let foregroundTop = bouncesHeader ? max(0, parallax) : parallax
        
        if connectingConstraint.constant != foregroundTop {
            connectingConstraint.constant = foregroundTop
        }
        
//        if let view = backgroundLayout as? UIView
//            where !bouncesHeader {
//            
//            let bouncing = scrollView.contentOffset.y < -scrollView.contentInset.top
//            let bounceOffset = scrollView.contentOffset.y + scrollView.contentInset.top
//            let transform = bouncing ? CGAffineTransformMakeTranslation(0, bounceOffset) : CGAffineTransformIdentity
//            
//            if !CGAffineTransformEqualToTransform(view.transform, transform) {
//                view.transform = transform
//            }
//        }
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
}