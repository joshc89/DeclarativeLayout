//
//  DetailPageLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 19/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Adds Convenience initialiser for `ParallaxScrollLayout`.
public extension ParallaxScrollLayout {
    
    // MARK: Convenience Initialisers
    
    /**
     
     Convenience initialiser stacking a `TitledLayout` with a given `contentLayout` nested inside a white view as the `foregroundLayout`. This is a common layout for a detail page such as an article.
     
     - parameter backgroundLayout: Set as the `backgroundLayout` property.
     - parameter title: Set as the title in the `TitledLayout`.
     - parameter subtitle: Set as the subtitle in the `TitledLayout`.
     - parameter contentLayout: Stacked below the `TitledLayout`, this is the main point of customisation for this layout.
     - parameter scrollContentEdge: The edge the stacked content should be aligned to within the scroll view. Default value is `.ReadableContent`.
     - parameter withInsets: Extra inset to align the stacked content with the `scrollContentEdge`. Default value is zero.
     
    */
    public convenience  init(backgroundLayout: Layout,
                             title:String?,
                             subtitle:String?,
                             contentLayout: Layout,
                             scrollContentEdge: UIView.Edge = .ReadableContent,
                             withInsets: UIEdgeInsets = UIEdgeInsetsZero) {
        
        let titleLayout = TitledLayout(title: title, subtitle: subtitle)
        
        let scrollContent = UIStackView(arrangedLayouts: [titleLayout, contentLayout])
        scrollContent.axis = .Vertical
        scrollContent.spacing = 16.0
        scrollContent.translatesAutoresizingMaskIntoConstraints = false
        
        // give the scroll content a white background by nesting in a view.
        let scrollContentView = UIView()
        scrollContentView.backgroundColor = UIColor.whiteColor()
        scrollContentView.preservesSuperviewLayoutMargins = true
        
        scrollContentView.addSubview(scrollContent)
        
        let contentConstraints = scrollContent.constraintsAligningEdgesTo(scrollContentView.anchorsForEdge(scrollContentEdge), withInsets: withInsets)
        NSLayoutConstraint.activateConstraints(contentConstraints)
        
        // create the layout
        self.init(backgroundLayout: backgroundLayout, foregroundLayout: scrollContentView)
    }
}