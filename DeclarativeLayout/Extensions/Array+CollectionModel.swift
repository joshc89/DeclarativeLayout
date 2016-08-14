//
//  Array+CollectionModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

// TODO: extend generic typealias in Swift 3
// typealias EquivalentArray<T: Equivalent> = Array<T>


extension Array: CollectionSection {
    
// MARK: CollectionSection Conformance (i.e. Subsection)
    
    public var sectionTitle: String? {
        return nil
    }
    
    public var sectionIndexTitle: String? {
        return nil
    }
    
    public func numberOfItems() -> Int {
        return count
    }
    
    public func itemAtIndex(index: Int) -> Element {
        return self[index]
    }
    
}

// MARK: - CollectionModel Conformance

/*
extension Array: CollectionModel {
    
    // MARK: Single Section Collection
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    public func numberOfItemsInSection(section: Int) -> Int {
        return count
    }
    
    public func itemAtIndexPath(indexPath: NSIndexPath) -> Element {
        return self[indexPath.item]
    }
    
    public func titleForSection(section: Int) -> String? {
        return nil
    }
    
    public func indexTitleForSection(section: Int) -> String? {
        return nil
    }
}
*/

extension Array where Element: CollectionSection {
    
    // MARK: Array of CollectionSections
    
    public func numberOfSections() -> Int {
        return count
    }
    
    public func numberOfItemsInSection(section: Int) -> Int {
        
        return self[section].numberOfItems()
    }
    
    public func itemAtIndexPath(indexPath: NSIndexPath) -> Element.Element {
        return self[indexPath.section].itemAtIndex(indexPath.row)
    }
    
    public func titleForSection(section: Int) -> String? {
        return self[section].sectionTitle
    }
    
    public func indexTitleForSection(section: Int) -> String? {
        return self[section].sectionIndexTitle
    }
}
