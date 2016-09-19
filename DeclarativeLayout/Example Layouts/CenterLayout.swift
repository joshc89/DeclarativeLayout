//
//  CenteredLayout.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 19/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/// Layout that centers a child `Layout` within a `UILayoutGuide`.
public struct CenterLayout: Layout {
    
    /// The `Layout` to be centered within a `boundary` `UILayoutGuide`.
    public let child: Layout
    
    /**
     
     Default initialisaer. Creates a new `UILayoutGuide` as the boundary and centers `child` on it with the given parameters passed to `constraintsCentering(on:)`.
     
     - parameter child: The `Layout` to be centered in relation to the new `UILayoutGuide`.
     - parameter withOffset: Passed as an argument to `constraintsCentering(on:withOffset:xBuffer:yBuffer)`.
     - parameter xBuffer: Passed as an argument to `constraintsCentering(on:withOffset:xBuffer:yBuffer)`.
     - parameter yBuffer: Passed as an argument to `constraintsCentering(on:withOffset:xBuffer:yBuffer)`.
     
    */
    public init(child: Layout, withOffset: CGPoint = .zero, xBuffer:CGFloat? = 0, yBuffer:CGFloat? = 0) {
        
        self.child = child
        
        let edges = UILayoutGuide()
        
        self.elements = [edges, child]
        self.boundary = edges
        self.constraints = child.boundary.constraintsCentering(on: edges, withOffset: withOffset, xBuffer: xBuffer, yBuffer: yBuffer)
    }
    
    // MARK: Layout Conformance
    
    /// `Layout` conformance. Contains the boundary `UILayoutGuide` and the `child`.
    public let elements: [Layout]
    
    /// `Layout` conformance. A `UILayoutGuide` that `child` is constrained to be centered on.
    public let boundary: AnchoredObject
    
    /// `Layout` conformance. The constraints created on initialisation that center `child` on the `boundary`.
    public let constraints: [NSLayoutConstraint]
}
