//
//  TableDataSource.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func applyModification(modifications: CollectionModification, animated: Bool) {
        
        if animated {
        
            beginUpdates()
            
            if modifications.rowDeletions.count > 0 {
                deleteRowsAtIndexPaths(modifications.rowDeletions, withRowAnimation: .Automatic)
            }
            
            if modifications.rowInsertions.count > 0 {
                insertRowsAtIndexPaths(modifications.rowInsertions, withRowAnimation: .Automatic)
            }
            
            if modifications.rowReloads.count > 0 {
                reloadRowsAtIndexPaths(modifications, withRowAnimation: .Automatic)
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

public class TableLayout<CollectionType: CollectionModel>: NSObject, UITableViewDataSource, Layout {
    
    public let tableView: UITableView
    
    public private(set) var collection: CollectionType
    
    init(collection: CollectionType, style: UITableViewStyle = .Plain) {
        
        self.collection = collection
        
        tableView = UITableView(frame: CGRectZero, style: style)
    }
    
    public func updateCollection(collection: CollectionType, animated: Bool) {
        
        let oldValue = self.collection
        self.collection = collection
        
        tableView.applyModification(oldValue.modificationsBetween(collection), animated: animated)
    }
    
    // MARK: UITableViewDataSource Conformance
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return collection.numberOfSections()
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.numberOfItemsInSection(section)
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell(style: .Default, reuseIdentifier: "CollectionCell")
    }
    
    // MARK: Layout Conformance
    
    public var boundary: AnchoredObject {
        return tableView
    }
    
    public var elements: [Layout] {
        return [tableView]
    }
}
