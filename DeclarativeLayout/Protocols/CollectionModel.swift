//
//  CollectionModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/**
 
 Protocol defining the requirements of an object that can populate a 'collection' such as a `UITableView` or `UICollectionView`. 
 
 This is used to decouple default implementations of data sources from the type of data that is being used to populate the collection. In turn this allows for an abstract model object to be used to declaratively declare a collection such as a table or collection view.
 
 This protocol has an associated type, `Element`. If you are defining a list with multiple types in it (such as multiple post types, objects & advert panels) the associated `Element` type should be specified as an enum.
 
 For objects that want to hold a reference to a `CollectionModel` but cannot themselves be generic (such as `UIViewController`s from a storyboard) the type erased `AnyCollection` is provided.
 
 - seealso: `TableManager`
 - seealso: `TableLayout`
 - seealso: `ArrayCollection`
 
 */
public protocol CollectionModel {
    
    /// The type of object in this list.
    associatedtype Element
    
    // MARK: Population
    
    /// Should return the number of sections that make up this collection.
    func numberOfSections() -> Int
    
    /// Should return the number of items in a given section of this collection.
    func numberOfItems(in: Int) -> Int
    
    /// Should return the item at the given index path in the collection.
    func item(at: IndexPath) -> Element
    
    // MARK: Supplementary
    
    /// Should return an optional title for the section at the given index.
    func title(forSection: Int) -> String?
    
    /// Should return an optional index title for this section.
    func indexTitle(forSection: Int) -> String?
    
}

public extension CollectionModel {
    
    /// Default implementation returning `nil` for the section title. Specific implementatsion can provide a value if appropriate.
    public func title(forSection: Int) -> String? {
        return nil
    }
    
    /// Default implementation returning `nil` for the section index title. Specific implementatsion can provide a value if appropriate.
    public func indexTitle(forSection: Int) -> String? {
        return nil
    }
    
    /** 
     
     Convenience method collating the number of items in each section of this collection. This can be useful when iterating through the collection, perhaps calculating a `CollectionModification` difference.
     
     - returns: Tuple of the total number of sections and the number of items in each.
    */
    public func counts() -> (totalSections: Int, sectionCounts: [Int]) {
        let totalSections = numberOfSections()
        let counts = (0..<totalSections)
            .map { self.numberOfItems(in: $0) }
        
        return (totalSections, counts)
    }
}
