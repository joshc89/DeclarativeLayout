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
    
    /// The `Layout` that is moved in response to `scrollView.contentOffset` to give the parallax effect. Sits behind `foreground` in the hierarchy.
    public let background:Layout
    
    /// The `Layout` that acts as the content in the foreground of the parallax effect. Sits above `background` in the hierarchy.
    public let foreground:Layout
    
    /// The scroll view that performs the scroll, in response to which `background`'s position is adjusted to give the parallax effect.
    public let scrollView = UIScrollView()
    
    /// Internal variable for the constraint connecting the background and foreground. The constant is adjusted to implement the parallax scroll.
    let connectingConstraint: NSLayoutConstraint
    
    /// Internal variable to give a constant space between the top of the foreground and top of the scroll view content. As the background `Layout` moves, the content size of the scroll view permanently changes. This makes the scrolling stuttered and prevents the view from bouncing.
    let backgroundSpaceGuide: UILayoutGuide
    
    /// Flag for whether or not `background` should be pulled down with `foreground` or remain at the top of `scrollView`. Default value is `false`.
    public var bouncesBackground: Bool = false {
        didSet {
            if bouncesBackground != oldValue {
                // recalculate the offset
                didScroll(view: scrollView)
            }
        }
    }
    
    /// The rate at which `background`'s position is adjusted compared to `scrollView.contentOffset`. Default value is 0.5.
    public var scrollRate: CGFloat = 0.5 {
        didSet {
            if scrollRate != oldValue {
                // recalculate the offset
                didScroll(view: scrollView)
            }
        }
    }
    
    /// Default initialiser setting the two `Layout` properties. Adds `self` as an observer to the `contentOffset` of `scrollView`. This allows other objects to be the `UIScrollViewDelegate`.
    public init(background: Layout, foreground: Layout) {
        
        self.background = background
        self.foreground = foreground
        
        backgroundSpaceGuide = UILayoutGuide()
        
        // configure the scroll view
        scrollView.preservesSuperviewLayoutMargins = true
        scrollView.add(layout: background)
        scrollView.add(layout: backgroundSpaceGuide)
        scrollView.add(layout: foreground)
        
        scrollView.alwaysBounceVertical = true
        
        // create the internal constraints, some of which are properties so must be done before super.init
        scrollView.widthAnchor.constraint(equalTo: foreground.boundary.widthAnchor).isActive = true
        
        backgroundSpaceGuide.heightAnchor.constraint(equalTo: background.boundary.heightAnchor)
        
        let gTop = backgroundSpaceGuide.topAnchor.constraint(equalTo: scrollView.topAnchor)
        let gBottom = backgroundSpaceGuide.bottomAnchor.constraint(equalTo: foreground.boundary.topAnchor)
        
        let gLeading = backgroundSpaceGuide.boundary.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        let gTrailing = backgroundSpaceGuide.boundary.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        
        let gHeight = backgroundSpaceGuide.heightAnchor.constraint(equalTo: background.boundary.heightAnchor)
        
        let bLeading = background.boundary.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        let bTrailing = background.boundary.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        
        connectingConstraint = background.boundary.bottomAnchor.constraint(equalTo: foreground.boundary.topAnchor)
        
        let fLeading = foreground.boundary.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        let fTrailing = foreground.boundary.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        let fBottom = foreground.boundary.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        
        boundary = scrollView
        elements = [scrollView]
        constraints = [gTop, gBottom, gLeading, gTrailing, gHeight, bLeading, bTrailing, connectingConstraint, fLeading, fTrailing, fBottom]
        
        super.init()
        
        // observe the offset to perform the scroll
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: [.old, .new], context: nil)
    }
    
    deinit {
        scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    // MARK: Parallax Scroll Methods
    
    /// Responds to observing the `contentOffset` of `scrollView` and `frame` changes of `background`.
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let sv = object as? UIScrollView
            , keyPath == "contentOffset" {
            didScroll(view: sv)
        }
    }
    
    /// Implements the parallax scroll view by adjusting the constraint aligning the `background` top with `boundary`.
    public func didScroll(view:UIScrollView) {
        
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
    
    /// A UILayoutGuide aligning the `background` and `scrollView`.
    public let boundary: AnchoredObject
    
    /// - returns: The containing `boundary` UILayoutGuide, `background` and `scrollView`.
    public let elements: [Layout]
    
    /// A UILayoutGuide aligning the `background` and `scrollView`.
    public let constraints: [NSLayoutConstraint]
}
