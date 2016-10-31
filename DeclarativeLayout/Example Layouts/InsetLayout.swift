//
//  InsetLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Simple Layout adding an inset boundary to a child `Layout`. This is useful for example to inset some views inside a stack.
public struct InsetLayout: Layout {
    
    /// The `Layout` to be inset.
    public let child: Layout
    
    /// The insets between the child and the containing layout guide.
    var insets: UIEdgeInsets {
        didSet {
            
            if insets == oldValue {
                return
            }
            
            constraints[0].constant = insets.top
            constraints[1].constant = insets.left
            constraints[2].constant = insets.bottom
            constraints[3].constant = insets.right
        }
    }
    
    /// The boundary of this layout is a `UILayoutGuide` used to provide the insets.
    public let boundary: AnchoredObject
    
    /// The bounding layout guide and the child layout.
    public let elements: [Layout]
    
    /// The constraints to inset child from the edge.
    public let constraints: [NSLayoutConstraint]
    
    /**
     
     Default initialiser.
     
     - parameter child: The sub layout that is to be inset.
     - parameter insets: The amount to inset `child` from the bounding layout guide.
     
    */
    public init(child: Layout, insets:UIEdgeInsets) {
        
        self.child = child
        self.insets = insets
        
        let insetGuide = UILayoutGuide()
        boundary = insetGuide
        elements = [insetGuide, child]
        constraints = child.boundary.constraintsAligningEdges(to: insetGuide, withInsets: insets)
    }
}
