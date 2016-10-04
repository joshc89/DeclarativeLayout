//
//  RatioLayout.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 19/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/// `Layout` that stacks two children with a proportional sizing constraint between them.
public class RatioLayout: BaseLayout {
    
    /// The initial view in `stack`, whose size is used as a reference for sizing `proportional` with `ratio`.
    public let reference: Layout
    
    /// The final view in `stack`, whose size is calculated from `reference` using `ratio`.
    public let proportional: Layout
    
    /// The proportional size between `reference` and `proportional` in the dimension corresponding to `axis`. As the `multiplier` of an `NSLayoutConstraint` is read-only this cannot be modified after initialisation either.
    public let ratio: CGFloat
    
    /// The stack containing `reference` and `proportional`, configured on initialisation. Note, in order for the ratio constraints to be applied correctly, the axis of this `Layout` should be changed through the `axis` property rather than through this `stack`. This defines the `boundary` and `elements` of this `Layout`
    public let stack: UIStackView
    
    /// The `axis` that the children are aligned along in `stack`. This should be set instead of modifying `stack` so the ratio constraints are activated correctly.
    public var axis: UILayoutConstraintAxis {
        didSet {
            stack.axis = axis
            
            switch axis {
            case .horizontal:
                vRatioConstraint.isActive = false
                hRatioConstraint.isActive = true
            case .vertical:
                vRatioConstraint.isActive = true
                hRatioConstraint.isActive = false
            }
        }
    }
    
    /// Internal constraint enforcing the ratio when the axis is vertical
    let vRatioConstraint: NSLayoutConstraint
    
    /// Internal constraint enforcing the ratio when the axis is horizontal
    let hRatioConstraint: NSLayoutConstraint
    
    /**
     
     Default initialiser creating `stack` containing the two child `Layout`s. `stack` is configured with the given properties.
     
     - parameter reference: Set as `reference`
     - parameter proportional: Set as `proportional`
     - parameter ratio: Set as `ratio`.
     - parameter axis: Set as `axis` configuring the created `stack`. Default value is `.horizontal`.
     - parameter spacing: The spacing with `stack`. Default value is 8.0.
     
    */
    public init(reference:Layout, proportional: Layout, ratio: CGFloat, axis: UILayoutConstraintAxis = .horizontal, spacing: CGFloat = 8.0) {
        
        self.reference = reference
        self.proportional = proportional
        self.ratio = ratio
        self.axis = axis
        
        stack = UIStackView(arrangedLayouts: [reference, proportional])
        stack.axis = axis
        stack.spacing = spacing
        
        vRatioConstraint = proportional.boundary.widthAnchor.constraint(equalTo: reference.boundary.widthAnchor, multiplier: ratio)
        
        hRatioConstraint = proportional.boundary.heightAnchor.constraint(equalTo: reference.boundary.heightAnchor, multiplier: ratio)
        
        super.init(view: stack)
     
        // activate the ratio constraint now rather than as part of the `constraints` property so it can be managed through the `axis` property.
        switch axis {
        case .horizontal:
            hRatioConstraint.isActive = true
        case .vertical:
            vRatioConstraint.isActive = true
        }
    }
}
