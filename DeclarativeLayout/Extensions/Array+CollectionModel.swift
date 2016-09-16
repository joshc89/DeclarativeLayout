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
    
    public func item(at: Int) -> Element {
        return self[at]
    }
    
}

extension Array where Element: CollectionSection {
    
    // MARK: Array of CollectionSections
    
    public func numberOfSections() -> Int {
        return count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        
        return self[section].numberOfItems()
    }
    
    public func item(at indexPath: IndexPath) -> Element.Element {
        return self[indexPath.section].item(at: indexPath.row)
    }
    
    public func title(forSection: Int) -> String? {
        return self[forSection].sectionTitle
    }
    
    public func indextitle(forSection: Int) -> String? {
        return self[forSection].sectionIndexTitle
    }
}
