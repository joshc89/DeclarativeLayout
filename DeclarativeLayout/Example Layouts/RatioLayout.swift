//
//  RatioLayout.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 19/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

public struct RatioLayout: Layout {
    
    public let reference: Layout
    
    public let proportional: Layout
    
    public let ratio: CGFloat
    
    public let axis: UILayoutConstraintAxis
    
    public init(reference:Layout, proportional: Layout, ratio: CGFloat, axis: UILayoutConstraintAxis = .horizontal, spacing: CGFloat = 8.0) {
        
        self.reference = reference
        self.proportional = proportional
        self.ratio = ratio
        self.axis = axis
        
        let stack = UIStackView(arrangedLayouts: [reference, proportional])
        stack.axis = axis
        stack.spacing = spacing
        
        elements = [stack]
        boundary = stack
        constraints = [proportional.boundary.widthAnchor.constraint(equalTo: reference.boundary.widthAnchor, multiplier: ratio)]
        
        // TODO: vConstrs / hConstrs activate and deactivate if the axis changes. Cannot modify the multiplier after creation so would just create new Layout and disable old one before enabling the new one
    }
    
    // MARK: Layout Conformance
    
    /// `Layout` conformance. Contains the boundary `UILayoutGuide` and the `child`.
    public let elements: [Layout]
    
    /// `Layout` conformance. A `UILayoutGuide` that `child` is constrained to be centered on.
    public let boundary: AnchoredObject
    
    /// `Layout` conformance. The constraints created on initialisation that center `child` on the `boundary`.
    public let constraints: [NSLayoutConstraint]
    
}
