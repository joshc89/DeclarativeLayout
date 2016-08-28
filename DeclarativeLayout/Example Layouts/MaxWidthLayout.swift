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
     
        let insetGuide = UILayoutGuide()
        boundary = insetGuide
        elements = [insetGuide, child]
        
        widthConstraint = child.boundary.widthAnchor.constraintLessThanOrEqualToConstant(maxWidth)
        widthConstraint.active = true
    }
    
    // MARK: Layout Conformance
    
    /// The boundary is a UILayoutGuide that `child`'s `boundary` is aligned to.
    public let boundary: AnchoredObject
    
    /// `boundary` and `child`.
    public let elements: [Layout]
    
    /**
     
     Creates the constraints to align `child` with a restricted width.
     
     - returns: Constraints ordered top, botton, centerX, >= leading
    */
    public func generateConstraints() -> [NSLayoutConstraint] {
        
        guard let guide = boundary as? UILayoutGuide else {
            return elementConstraints()
        }
        
        let edgeConstraints = child.boundary.constraintsAligningEdgesTo(guide)
        
        let cX = child.boundary.centerXAnchor.constraintEqualToAnchor(guide.centerXAnchor)
        
        let leading = child.boundary.leadingAnchor.constraintGreaterThanOrEqualToAnchor(guide.leadingAnchor)
        
        return [edgeConstraints[0], edgeConstraints[2], cX, leading]
    }
}