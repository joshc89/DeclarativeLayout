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
    func generateConstraints() -> [NSLayoutConstraint]
}

public extension Layout {
    
    /// Convenience function returning the combined constraints for all of the `Layout`s in `elements`.
    public func elementConstraints() -> [NSLayoutConstraint] {
        return elements.reduce([], { $0 + $1.generateConstraints() })
    }
    
    /// Default implementation returning the `elementConstraints()`.
    public func generateConstraints() -> [NSLayoutConstraint] {
        return elementConstraints()
    }
    
    /// Recursive function updating all the child `UIView`s in `elements` to have `translatesAutoresizingMaskIntoConstraints` to `false`.
    public func useInAutoLayout() {
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
