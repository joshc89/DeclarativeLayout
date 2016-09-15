//
//  AnchoredObject.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Public typealias allowing properties on an `AnchoredObject`s such as UIView and UILayoutGuide to be observed.
public typealias AnchoredNSObject = AnchoredObject & NSObjectProtocol

/**
 
 Protocol definig the required properties of an object to be part of a constraint based layout system using `Layout`.
 
 `UIView` and `UILayoutGuide` both conform to this protocol so they can be used interchangably in a `Layout`.
 
 */
public protocol AnchoredObject {
    
    // MARK: X-Axis Anchors
    
    /// A layout anchor representing the left edge of the layout guide’s frame.
    var leftAnchor: NSLayoutXAxisAnchor { get }
    
    /// A layout anchor representing the leading edge of the layout guide’s frame.
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    
    /// A layout anchor representing the horizontal center of the layout guide’s frame.
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    
    /// A layout anchor representing the trailing edge of the layout guide’s frame.
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    
    /// A layout anchor representing the right edge of the layout guide’s frame.
    var rightAnchor: NSLayoutXAxisAnchor { get }
    
    // MARK: Y-Axis Anchors
    
    /// A layout anchor representing the top edge of the layout guide’s frame.
    var topAnchor: NSLayoutYAxisAnchor { get }
    
    /// A layout anchor representing the vertical center of the layout guide’s frame.
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    
    /// A layout anchor representing the bottom edge of the layout guide’s frame.
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    
    // MARK: Dimension Anchors
    
    /// A layout anchor representing the width of the layout guide’s frame.
    var widthAnchor: NSLayoutDimension { get }
    
    /// A layout anchor representing the height of the layout guide’s frame.
    var heightAnchor: NSLayoutDimension { get }
}

public extension AnchoredObject {
    
    // MARK: Convenience Constraint Creators
    
    /**
     
     Creates constraints aligning self to another `AnchoredObject` at each edge using leading and trailing over left and right.
     
     - parameter to: The other object to align this object's edges to.
     - parameter withInsets: The constants to set for each edge constraint. Default value is zeros.
     
     - returns: An array of created constraints in the order top, leading, bottom, trailing.
    */
    public func constraintsAligningEdges(to:AnchoredObject, withInsets:UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        
        return [
            topAnchor.constraint( equalTo: to.topAnchor, constant: withInsets.top),
            leadingAnchor.constraint( equalTo: to.leadingAnchor, constant: withInsets.left),
            bottomAnchor.constraint( equalTo: to.bottomAnchor, constant: -withInsets.bottom),
            trailingAnchor.constraint( equalTo: to.trailingAnchor, constant: -withInsets.right),
        ]
    }
    
    /**
     
     Creates constraints aligning the center of self to the center of another `AnchoredObject`. Optionally creates greater than or equal to constraints against the leading and top edges to prevent overflow.
     
     - parameter on: The other object to align this object's center with.
     - parameter withOffset: The amount off center this view should be. Default value is zeros.
     - parameter xBuffer: If not nil, this is the minimum distance from the leading edge of `on`. This can be used to prevent horizontal overflow.
     - parameter yBuffer: If not nil, this is the minimum distance from the top edge of `on`. This can be used to prevent vertical overflow.
     
     - returns: An array of created constraints in the order centerX, centerY, xBuffer, yBuffer.
     
    */
    public func constraintsCentering(on: AnchoredObject, withOffset:CGPoint = CGPoint.zero, xBuffer:CGFloat? = nil, yBuffer:CGFloat? = nil) -> [NSLayoutConstraint] {
        
        return [
            centerXAnchor.constraint( equalTo: on.centerXAnchor, constant: withOffset.x),
            centerYAnchor.constraint( equalTo: on.centerYAnchor, constant: withOffset.y),
            xBuffer.flatMap { self.leadingAnchor.constraint(greaterThanOrEqualTo: on.leadingAnchor, constant: $0) },
            yBuffer.flatMap { self.topAnchor.constraint(greaterThanOrEqualTo: on.topAnchor, constant: $0) }
            ].flatMap { $0 }
    }
    
    /**
     
     Creates constraints to size self to a given size.
     
     - parameter to: The size to constrain self to.
     - paramter priority: The priority of the size constraints. Default value is 1000.
     
    */
    public func constraintsSizing(to:CGSize, priority:UILayoutPriority = 1000) -> [NSLayoutConstraint] {
        
        let constraints = [
            widthAnchor.constraint(equalToConstant: to.width),
            heightAnchor.constraint(equalToConstant: to.height)
        ]
        
        if priority < 1000 {
            constraints.forEach { $0.priority = priority }
        }
        
        return constraints.flatMap { $0 }
    }
}
