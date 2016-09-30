//
//  FittingFlowLayout.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 19/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/**
 
 Simple `UICollectionViewFlowLayout` that caluclates the item size such that there is fixed space between cells. This can give a neater grid layout that using just `UICollectionViewFlowLayout`.
 
 The exact `itemSize` is calulated based on the `targetSize` property, combined with the available space, `sectionInset` and `minimumInterItemSpacing`. The scroll direction determines whether the `targetSize` is interpretted as the width or height, and whether the `fittingSize(for:)` returns the exact width or height.
 
*/
open class FittingFlowLayout: UICollectionViewFlowLayout {
    
    /**
     The ratio of the height to the width. e.g.
                    
         width * ratio = height
     
     So 16:9 => ratio = 0.5625
    */
    open var heightRatio: CGFloat = 1.0 {
        didSet {
            invalidateLayout()
        }
    }
    
    /// The size used to compute the fitting size for the cells in `fittingSize(for:)`. The exact number of cells that can fit in the collection view is calculated using this size, then rounded to produce the actual cell count. The exact cell size is therefore not guarenteed to equal this size.
    open var targetSize: CGFloat = 185.0 {
        didSet {
            invalidateLayout()
        }
    }
    
    /**
     Convenience method for calculating the number of columns for a given space that will closest match `targetSize`.
    
     - parameter for: The total space this layout can take up against the `scrollDirection`.
    
     - returns: The number of columns that closest fits that when using the `targetSize`.
    */
    open func columnCount(for totalSpace: CGFloat) -> Int {
        
        let inset: CGFloat
        
        switch scrollDirection {
        case .horizontal:
            inset = sectionInset.top + sectionInset.bottom
        case .vertical:
            inset = sectionInset.left + sectionInset.right
        }
        
        let exactCount = (totalSpace - inset + minimumInteritemSpacing) / (targetSize + minimumInteritemSpacing)
        
        return Int(round(exactCount))
    }
    
    
    // W = s.l + s.r + n * w + (n - 1) * s
    // W = s.l + s.r + n * ( w + s) - s
    // (W + s - s.l - s.r) / (w + s) = n
    
    /**
     
     Convenience method for calculating the exact dimension of a cell for a given space that will closest match `targetSize` with fixed spacing between the items.
     
     - seealso: `columnCount(for:)`
     
     - parameter for: The total space this layout can take up against the `scrollDirection`
     
     - returns: Either the `height` or `width` for the `itemSize` that will result in fixed spacing and margins given the `scrollDirection` being `.horizontal` or `.vertical` respectively.
     
    */
    open func fittingSize(for totalSpace: CGFloat) -> CGFloat {
        
        let count = columnCount(for: totalSpace)
        
        return (totalSpace - sectionInset.left - sectionInset.right - CGFloat(count - 1) *  minimumInteritemSpacing) / CGFloat(count)
    }
    
    open func itemSize(for totalSpace: CGFloat) -> CGSize {
        
        switch scrollDirection {
        case .horizontal:
            let height = fittingSize(for: totalSpace)
            return CGSize(width: height / heightRatio, height: height)
        case .vertical:
            let width = fittingSize(for: totalSpace)
            return CGSize(width: width, height: width * heightRatio)
        }
    }
    
    /// Calculates the `itemSize` based on the `bounds` of `collectionView`.
    open override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else { return }
        
        self.itemSize = itemSize(for: cv.bounds.size.width)
    }
    
    /// Triggers invalidation if and only if the dimension against the `scrollDirection` will change.
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        guard let cv = collectionView else { return false }
        
        let invalidated:Bool
        switch scrollDirection {
        case .horizontal:
            invalidated = newBounds.size.height != cv.bounds.size.height
        case .vertical:
            invalidated = newBounds.size.width != cv.bounds.size.width
        }
        
        if invalidated {
            self.itemSize = itemSize(for: newBounds.size.width)
            self.invalidateLayout()
        }
        
        return invalidated
    }
}

