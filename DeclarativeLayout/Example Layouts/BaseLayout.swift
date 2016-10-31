//
//  BaseLayout.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 04/10/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Convenience class for simple conformance to `Layout` by initialising with the required properties.
open class BaseLayout: Layout {
    
    /// `Layout` conformance, set on initialisation.
    public let boundary: AnchoredObject
    
    /// `Layout` conformance, set on initialisation.
    public let elements: [Layout]
    
    /// `Layout` conformance, set on initialisation.
    public let constraints: [NSLayoutConstraint]
    
    /**
     
     Convenience initialiser for creating a layout from a single view. This is useful for creating a layout from a `UIStackView` with defined properties for its subviews.
     
     - parameter view: This becomes `boundary` and only item in `elements`.
     
     - seealso: `init(boundary:elements:constraints:)`
    */
    public init(view: UIView) {
        boundary = view
        elements = [view]
        constraints = []
    }
    
    /// Default initialiser setting the properties for layout conformance
    public init(boundary: AnchoredObject, elements: [Layout], constraints: [NSLayoutConstraint]) {
        self.boundary = boundary
        self.elements = elements
        self.constraints = constraints
    }
}
