//
//  OverlayLayout.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 19/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/// Layout that aligns a collection of child `Layout`s to a common `UILayoutGuide`.
public struct OverlayLayout: Layout {
    
    /// The `Layout`s to be overlayed aligned to a common `UILayoutGuide`.
    public let children: [Layout]
    
    /**
     
     Default initialiser. Creates a new `UILayoutGuide` as the boundary and aligns each child `Layout` with this boundary.
     
     - parameter children: The `Layout`s to be aligned with a common boundary. They are added to `elements` in the order they are given here.
     - parameter withInsets: Passed as an argument to `constraintsAligningEdges(to:withInsets:)`.
     
    */
    public init(children: [Layout], withInsets: UIEdgeInsets = .zero) {
        
        self.children = children
        
        let edges = UILayoutGuide()
        
        self.elements = [edges] + children
        self.boundary = edges
        let all: [NSLayoutConstraint] = children.map { edges.constraintsAligningEdges(to: $0.boundary, withInsets: withInsets) }
            .reduce([], +)
        self.constraints = all
    }
    
    // MARK: Layout Conformance
    
    /// `Layout` conformance. Contains the boundary `UILayoutGuide` and the `children`.
    public let elements: [Layout]
    
    /// `Layout` conformance. A `UILayoutGuide` that each `Layout` in `children` is aligned to.
    public let boundary: AnchoredObject
    
    /// `Layout` conformance. The constraints created on initialisation that aligned each child to the `boundary`.
    public let constraints: [NSLayoutConstraint]
}
