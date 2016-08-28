//
//  UIView+DeclarativeLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Extension to provide automatic conformance of UIView to `AnchoredObject` with other convenience methods. UIView also conforms to `Layout` so it can be used interchangably with more complex layouts to improve usability of layouts.
extension UIView: AnchoredObject {

    /// Synonym for frame used for `AnchoredObject` conformance.
    public var layoutFrame:CGRect {
        return frame
    }
    
    /**
     
     Adds the subview or layout guide to self.
     
     - parameter AnchoredObject: The `UIView` or `UILayoutGuide` to add to the hierarchy. This allows for the interchangable use of the 2 types in creating a `Layout`.
    */
    public func addAnchoredObject(anchoredObject: AnchoredObject) {
        switch anchoredObject {
        case let view as UIView:
            addSubview(view)
        case let guide as UILayoutGuide:
            addLayoutGuide(guide)
        default: break
        }
    }
    
    /**
     
     Adds each element to the hierarchy, calling `useInAutoLayout()` then activates the constraints for that `Layout`.
     
     - returns: The constraints that were generated. If you want to dynamically de-activate and re-activate these constraints you should hold on to these.
    */
    public func addLayout(layout: Layout) -> [NSLayoutConstraint] {
        
        layout.useInAutoLayout()
        
        for element in layout.elements {
            if let obj = layout as? AnchoredObject {
                addAnchoredObject(obj)
            } else {
                addLayout(element)
            }
        }
        
        let toAdd = layout.generateConstraints()
        NSLayoutConstraint.activateConstraints(toAdd)
        return toAdd
    }

}

// MARK: Convenience Methods
public extension UIView {
    
    /// Sets all of the given views' `translatesAutoresizingMaskIntoConstraints` to `false`. When creating views programmatically this is set to `true` by default, which is inconvenient when creating UI programmatically using NSLayoutConstraints.
    public class func useInAutoLayout(views:[UIView]) {
        views.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
    }
    
}

// MARK: Layout Conformance
extension UIView: Layout {
    
    /// `self` is the bounding layout as this view represents the entire layout.
    public var boundary: AnchoredObject {
        return self
    }
    
    /// The only element is `self` as this view represents the entire layout.
    public var elements: [Layout] {
        return [self]
    }
    
    /// There are no internal constraints needed to configure this view.
    public func generateConstraints() -> [NSLayoutConstraint] {
        return []
    }
}


/// Extension of `UIView` enumerating the types of edge.
public extension UIView {
    
    /**
 
     Type enumerating the types of edges a view can align its content to. These can be passed in as a parameter to a `Layout` to allow the user to customise the layout within specific parameters.
     
     - seealso: `ParallaxScrollLayout`'s convenience initialisers. 
 
    */
    public enum Edge {
        /// Represents the boundary of this view.
        case Bounds
        /// Represents the `layoutMarginsGuide` of this view.
        case LayoutMargins
        /// Represents the `readableContentGuide` of this view.
        case ReadableContent
    }
    
    /**
     
     Convenience method allowing access to a representation of `UIView.Edge`.
     
     - parameter edge: The type of edge requested.
     - returns: either the views boundary (i.e. `self`), `layoutMarginsGuide` or `readableContentGuide`.
    */
    public func anchorsForEdge(edge: Edge) -> AnchoredObject {
    
        switch edge {
        case .Bounds:
            return self
        case .LayoutMargins:
            return layoutMarginsGuide
        case .ReadableContent:
            return readableContentGuide
        }
    
    }
}