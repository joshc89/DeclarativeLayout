//
//  UICollectionView+CollectionModification.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 19/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    /**
     
     Convenience method for applying a modification to a `UICollectionView` collating all the changes within a `performBatchUpdates(_:completion:)`.
     
     - parameter modifications: The changes to apply to the collection.
     - parameter animated: If `true`, the changes are made using `deleteItems(at:)`, `insertItems(at:)` etc. If `false`, the changes are made using `reloadData()`.
     
     */
    public  func apply(modifications: CollectionModification, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        
        if animated {
            
            performBatchUpdates({
                
                if modifications.rowDeletions.count > 0 {
                    self.deleteItems(at: modifications.rowDeletions)
                }
                
                if modifications.rowInsertions.count > 0 {
                    self.insertItems(at: modifications.rowInsertions)
                }
                
                if modifications.rowReloads.count > 0 {
                    self.reloadItems(at: modifications.rowReloads)
                }
                
                for (from, to) in modifications.rowMoves {
                    self.moveItem(at: from, to: to)
                }
                
                if modifications.sectionInsertions.count > 0 {
                    self.insertSections(modifications.sectionInsertions)
                }
                
                if modifications.sectionDeletions.count > 0 {
                    self.deleteSections(modifications.sectionDeletions)
                }
                
                if modifications.sectionReloads.count > 0 {
                    self.reloadSections(modifications.sectionReloads)
                }
                
                for (from, to) in modifications.sectionMoves {
                    self.moveSection(from, toSection: to)
                }
                
                }, completion: completion)
            
        } else {
            reloadData()
        }   
    }
    
}
