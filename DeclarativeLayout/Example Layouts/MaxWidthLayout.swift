//
//  MaxWidthLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Simple `Layout` constraining the width of a child `Layout` to a maximum size. If the width of `child` would exceed that of `boundary` it is centered horizontally within `boundary`.
public struct MaxWidthLayout: Layout {
    
    /// Maximum width `child` can take.
    public var maxWidth:CGFloat {
        didSet {
            if maxWidth != oldValue {
                widthConstraint.constant = maxWidth
            }
        }
    }
    
    /// Child layout whose width should be restricted by `maxWidth`.
    public let child: Layout
    
    /// Internal variable constraining the width of `child` that is updated with `maxWidth`.
    let widthConstraint:NSLayoutConstraint
    
    /// Default initailiser setting the properties with the given values.
    public init(child: Layout, maxWidth: CGFloat) {
        
        self.child = child
        self.maxWidth = maxWidth
     
        let edges = UILayoutGuide()
        boundary = edges
        elements = [edges, child]
        
        widthConstraint = child.boundary.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth)
        
        let edgeConstraints = child.boundary.constraintsAligningEdges(to: edges)
        let cX = child.boundary.centerXAnchor.constraint(equalTo: edges.centerXAnchor)
        let leading = child.boundary.leadingAnchor.constraint(greaterThanOrEqualTo: edges.leadingAnchor)
        
        self.constraints = [edgeConstraints[0], edgeConstraints[2], cX, leading, widthConstraint]
    }
    
    // MARK: Layout Conformance
    
    /// The boundary is a UILayoutGuide that `child`'s `boundary` is aligned to.
    public let boundary: AnchoredObject
    
    /// `boundary` and `child`.
    public let elements: [Layout]
    
    /// Constraints internally aligning the edges of `child` to `boundary` with a restricted width.
    public let constraints: [NSLayoutConstraint]
}
