//
//  UITableView+CollectionModification.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 07/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

public extension UITableView {
    
    public func applyModification(modifications: CollectionModification, animated: Bool) {
        
        if animated {
            
            beginUpdates()
            
            if modifications.rowDeletions.count > 0 {
                deleteRowsAtIndexPaths(modifications.rowDeletions, withRowAnimation: .Automatic)
            }
            
            if modifications.rowInsertions.count > 0 {
                insertRowsAtIndexPaths(modifications.rowInsertions, withRowAnimation: .Automatic)
            }
            
            if modifications.rowReloads.count > 0 {
                reloadRowsAtIndexPaths(modifications.rowReloads, withRowAnimation: .Automatic)
            }
            
            for (from, to) in modifications.rowMoves {
                moveRowAtIndexPath(from, toIndexPath: to)
            }
            
            if modifications.sectionInsertions.count > 0 {
                insertSections(modifications.sectionInsertions, withRowAnimation: .Automatic)
            }
            
            if modifications.sectionDeletions.count > 0 {
                deleteSections(modifications.sectionDeletions, withRowAnimation: .Automatic)
            }
            
            if modifications.sectionReloads.count > 0 {
                reloadSections(modifications.sectionReloads, withRowAnimation: .Automatic)
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
