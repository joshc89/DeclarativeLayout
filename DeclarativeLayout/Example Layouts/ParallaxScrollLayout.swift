//
//  ParallaxScrollLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/**
 
 `Layout` for a background `Layout` that moves with a parallax scroll effect behind another `Layout`. 
 
 This is required to be an NSObject over a struct as it uses KVO to implement the parallax effect on the background as the user scrolls `scrollView`.
 
 */
public final class ParallaxScrollLayout: NSObject, Layout {
    
    /// The `Layout` that is moved in response to `scrollView.contentOffset` to give the parallax effect. Sits behind `foregroundLayout` in the hierarchy.
    public let backgroundLayout:Layout
    
    /// The `Layout` that acts as the content in the foreground of the parallax effect. Sits above `backgroundLayout` in the hierarchy.
    public let foregroundLayout:Layout
    
    /// The scroll view that performs the scroll, in response to which `backgroundLayout`'s position is adjusted to give the parallax effect.
    public let scrollView = UIScrollView()
    
    /// Internal variable for the constraint connecting the background and foreground. The constant is adjusted to implement the parallax scroll.
    let connectingConstraint: NSLayoutConstraint
    
    /// Internal variable to give a constant space between the top of the foreground and top of the scroll view content. As the background `Layout` moves, the content size of the scroll view permanently changes. This makes the scrolling stuttered and prevents the view from bouncing.
    let backgroundSpaceGuide: UILayoutGuide
    
    /// Flag for whether or not `backgroundLayout` should be pulled down with `foregroundLayout` or remain at the top of `scrollView`. Default value is `false`.
    public var bouncesBackground: Bool = false {
        didSet {
            if bouncesBackground != oldValue {
                // recalculate the offset
                scrollViewDidScroll(scrollView)
            }
        }
    }
    
    /// The rate at which `backgroundLayout`'s position is adjusted compared to `scrollView.contentOffset`. Default value is 0.5.
    public var scrollRate: CGFloat = 0.5 {
        didSet {
            if scrollRate != oldValue {
                // recalculate the offset
                self.scrollViewDidScroll(scrollView)
            }
        }
    }
    
    /// Default initialiser setting the two `Layout` properties. Adds `self` as an observer to the `contentOffset` of `scrollView`. This allows other objects to be the UIScrollViewDelegate.
    public init(backgroundLayout: Layout, foregroundLayout: Layout) {
        
        self.backgroundLayout = backgroundLayout
        self.foregroundLayout = foregroundLayout
        
        backgroundSpaceGuide = UILayoutGuide()
        
        // configure the scroll view
        scrollView.addLayout(backgroundLayout)
        scrollView.addLayout(backgroundSpaceGuide)
        scrollView.addLayout(foregroundLayout)
        
        scrollView.alwaysBounceVertical = true
        
        // create the internal constraints, some of which are properties so must be done before super.init
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
        
        let internalConstraints = [gTop, gBottom, gLeading, gTrailing, gHeight, bLeading, bTrailing, connectingConstraint, fLeading, fTrailing, fBottom].flatMap { $0 }
        
        NSLayoutConstraint.activateConstraints(internalConstraints)
        
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
        
        let foregroundTop: CGFloat
        if bouncesBackground {
            foregroundTop = max(0, parallax)
        } else {
            if offset > 0 {
                foregroundTop = parallax
            } else {
                foregroundTop = offset
            }
        }
        
        if connectingConstraint.constant != foregroundTop {
            connectingConstraint.constant = foregroundTop
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
}