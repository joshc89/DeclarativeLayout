//
//  UILayoutGuide+DeclarativeLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Extension to provide automatic conformance of UIView to `AnchoredObject`.
extension UILayoutGuide: AnchoredObject {}

// MARK: Layout Conformance
extension UILayoutGuide: Layout {
    
    /// `self` is the bounding layout as this this layout guide represents the entire layout.
    public var boundary: AnchoredObject {
        return self
    }
    
    /// The only element is `self` as this layout guide represents the entire layout.
    public var elements: [Layout] {
        return []
    }
}
