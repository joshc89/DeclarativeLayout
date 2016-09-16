//
//  UITableView+CollectionModification.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 07/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

public extension UITableView {
    
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
                insertSections(modifications.sectionInsertions as IndexSet, with: .automatic)
            }
            
            if modifications.sectionDeletions.count > 0 {
                deleteSections(modifications.sectionDeletions as IndexSet, with: .automatic)
            }
            
            if modifications.sectionReloads.count > 0 {
                reloadSections(modifications.sectionReloads as IndexSet, with: .automatic)
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
