//
//  UIStackView+DeclarativeLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

public extension UIStackView {
    
    /**
     
     Convenience initialiser to create a stack from arbitrary `Layout` objects. If the `boundary` of a given `Layout` is a `UIView` it is added directly to the stack. If the `boundary` of a given `Layout` is a `UILayoutGuide` it is added to a transparent container view before being added to the stack.
     
     Being able to stack generic `Layout`s allows for greater reuse and composition of `Layout` objects. 
     
     - parameter: The `Layout` objects to stack.
     
    */
    public convenience init(arrangedLayouts:[Layout]) {
        
        let views = arrangedLayouts.map { (layout) -> UIView in
            
            if let view = layout.boundary as? UIView, layout.elements.count <= 1 {
                return view
            } else {
                let container = UIView()
                container.backgroundColor = .clear
                container.translatesAutoresizingMaskIntoConstraints = false
                container.add(layout: layout)
                
                let edgeConstrs = layout.boundary.constraintsAligningEdges(to: container)
                NSLayoutConstraint.activate(edgeConstrs)
                
                return container
            }
        }
        
        self.init(arrangedSubviews: views)
    }
}
