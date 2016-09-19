//
//  FullBoundsLayout.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 19/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Simple `UICollectionViewFlowLayout` that calculates the item size such that the cells fill the bounds of the collection view. This can be used as a simple paging image view, perhaps to represent a series of hero images in a layout for a detail page.
open class FullBoundsFlowLayout: UICollectionViewFlowLayout {
    
    /// Creates the layout setting all spacings to `.zero`.
    override public init() {
        super.init()
        
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.sectionInset = .zero
    }
    
    /// Required initialiser just passes through to `super`.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Sets the item size based on the current `bounds` of `collectionView`.
    open override func prepare() {
        
        super.prepare()
        
        guard let cv = collectionView else { return }
        
        self.itemSize = cv.bounds.size
    }
    
    /// Invalidates the layout if and only if the `bounds.size` of `collectionView` will change.
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        guard let cv = collectionView else { return false }
        
        if cv.bounds.size != newBounds.size {
            self.itemSize = newBounds.size
            return true
        } else {
            return false
        }
    }
}
