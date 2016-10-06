//
//  UITableView+CollectionModification.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 07/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

public extension UITableView {
    
    /**
     
     Convenience method for applying a modification to a `UITableView` collating all the changes between calls to `beginUpdates()` and `endUpdates()`.
     
     - parameter modifications: The changes to apply to the table.
     - parameter animated: If `true`, the changes are made using `.automatic` animation style. If `false`, the changes are made using `reloadData()`.
     
    */
    public func apply(modifications: CollectionModification, animated: Bool) {
        
        if animated {
            
            beginUpdates()
            
            if modifications.rowDeletions.count > 0 {
                deleteRows(at: modifications.rowDeletions, with: .automatic)
            }
            
            if modifications.rowInsertions.count > 0 {
                insertRows(at: modifications.rowInsertions, with: .automatic)
            }
            
            if modifications.rowReloads.count > 0 {
                reloadRows(at: modifications.rowReloads, with: .automatic)
            }
            
            for (from, to) in modifications.rowMoves {
                moveRow(at: from, to: to)
            }
            
            if modifications.sectionInsertions.count > 0 {
                insertSections(modifications.sectionInsertions, with: .automatic)
            }
            
            if modifications.sectionDeletions.count > 0 {
                deleteSections(modifications.sectionDeletions, with: .automatic)
            }
            
            if modifications.sectionReloads.count > 0 {
                reloadSections(modifications.sectionReloads, with: .automatic)
            }
            
            for (from, to) in modifications.sectionMoves {
                moveSection(from, toSection: to)
            }
            
            endUpdates()
            
        } else {
            
            reloadData()
        }
    }
}
