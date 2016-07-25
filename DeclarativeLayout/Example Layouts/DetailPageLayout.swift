//
//  DetailPageLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 19/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit


public struct DetailPageLayout: Layout {
    
    public let titleLayout: TitledLayout
    
    public let scrollContent: UIStackView
    
    public let parallaxScrollLayout: ParallaxScrollLayout
    
    public init(title:String?,
         subtitle:String?,
         backgroundLayout: Layout,
         contentLayout: Layout,
         withInsets: UIEdgeInsets = UIEdgeInsetsMake(16, 8, 16, 8),
         maxWidth: CGFloat? = 667) {
        
        titleLayout = TitledLayout(title: title, subtitle: subtitle)
        
        scrollContent = UIStackView(arrangedLayouts: [titleLayout, contentLayout])
        scrollContent.axis = .Vertical
        scrollContent.spacing = 16.0
        
        // give the scroll content a white background
        let scrollContentView = UIView()
        scrollContentView.backgroundColor = UIColor.whiteColor()
        
        if let width = maxWidth {
            
            let maxWidthLayout = MaxWidthLayout(child: scrollContent, maxWidth: width)
            scrollContentView.addLayout(maxWidthLayout)
            
            // constrain the max width to the edges of the scroll view to give it contentSize
            let contentConstraints = maxWidthLayout.boundary.constraintsAligningEdgesTo(scrollContentView.layoutMarginsGuide, withInsets: withInsets)
            NSLayoutConstraint.activateConstraints(contentConstraints)
            
        } else {
            scrollContentView.addSubview(scrollContent)
            let contentConstraints = scrollContent.constraintsAligningEdgesTo(scrollContentView.layoutMarginsGuide, withInsets: withInsets)
            NSLayoutConstraint.activateConstraints(contentConstraints)
        }
        
        // create the layout
        parallaxScrollLayout = ParallaxScrollLayout(backgroundLayout: backgroundLayout, foregroundLayout: scrollContentView)
    }
 
    // MARR: Layout Conformance
    
    public var boundary: AnchoredObject {
        return parallaxScrollLayout.boundary
    }
    
    public var elements: [Layout] {
        return [parallaxScrollLayout]
    }
}