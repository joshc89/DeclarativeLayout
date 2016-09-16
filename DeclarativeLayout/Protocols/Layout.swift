//
//  Layout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/// Protocol defining the requirements for objects to provide a declarative layout using Auto Layout.
public protocol Layout {
    
    /// The `AnchoredObject` that should be used to position this `Layout` amongst others.
    var boundary: AnchoredObject { get }
    
    /// An array of sub-`Layout` objects that make up this `Layout`. These will be added to a `UIView` in the order they are given in this array in `add(layout: _:)`
    var elements: [Layout] { get }
    
    /// The constraints required to internally position this `Layout`. These should be activated once the `elements` of this `Layout` has been added to a super view. You should remember to add the constraints of any child Layouts in `elements`.
    var constraints: [NSLayoutConstraint] { get }
}

public extension Layout {
    
    /// Sets all of the nested `UIView`s' `isHidden` property. 
    public func hide(_ isHidden: Bool) {
        
        if let view = self as? UIView {
            view.isHidden = isHidden
        }
        
        for layout in elements {
            layout.hide(isHidden)
        }
    }
    
    var constraints: [NSLayoutConstraint] {
        return []
    }
    
    /// Convenience function returning the `constraints` for laying out `self` and all of the `constraints` for each `Layout` in `elements`, recursively generating them for all children.
    public func combinedConstraints() -> [NSLayoutConstraint] {
        return self.constraints + elements.reduce([], { $0 + $1.combinedConstraints() })
    }
    
    /// Recursive function updating all the child `UIView`s in `elements` to have `translatesAutoresizingMaskIntoConstraints` to `false`.
    public func useInAutoLayout() {
        
        if let view = self as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        for layout in elements {
            if let view = layout as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
            } else if layout is UILayoutGuide {
                // do nothing
            } else {
                // iterate sub layouts
                layout.useInAutoLayout()
            }
        }
    }
}
