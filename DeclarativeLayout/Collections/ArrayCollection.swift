//
//  ArrayCollection.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 07/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/// Struct that can hold an array of arbitrary `CollectionSection`s. This conforms to `CollectionModel` and therefore be used to populate a collection.
public struct ArrayCollection<SectionType: CollectionSection>: CollectionModel {
    
    /// The array of sections that populate this `CollectionModel`.
    public let sections: [SectionType]
    
    /// Default initialiser.
    public init(sections: [SectionType]) {
        self.sections = sections
    }
    
    /// MARK: CollectionModel Conformance
    
    /// `CollectionModel` conformance. Returns the count of `sections`.
    public func numberOfSections() -> Int {
        return sections.count
    }
    
    /// `CollectionModel` conformance. Forwards the request to the item at the given index in `sections`.
    public func numberOfItems(in section: Int) -> Int {
        return sections[section].numberOfItems()
    }
    
    /// `CollectionModel` conformance. Forwards the request to the item at the given index in `sections`.
    public func title(forSection: Int) -> String? {
        return sections[forSection].sectionTitle
    }
    
    /// `CollectionModel` conformance. Forwards the request to the item at the given index in `sections`.
    public func indextitle(forSection: Int) -> String? {
        return sections[forSection].sectionIndexTitle
    }
    
    /// `CollectionModel` conformance. Forwards the request to the item at the given index in `sections`.
    public func item(at indexPath: IndexPath) -> SectionType.Element {
        return sections[indexPath.section].item(at: indexPath.row)
    }
}

/// Struct that holds an array of elements forming a `CollectionSection`. This can be used with `ArrayCollection` to make a `CollectionModel` from an array of objects, such as showing data from a network request that has not been written to CoreData.
public struct ArraySection<Element>: CollectionSection {
 
    /// An array to store the elements in this section.
    public let items: [Element]
    
    /// `CollectionSection` conformance. The title of this section.
    public let sectionTitle: String?
    
    /// `CollectionSection` conformance. The index title of this section.
    public let sectionIndexTitle: String?
    
    /**
     
     Default initialiser, setting all properties.
     
     - parameter title: Sets the `sectionTitle`. Default value is `nil`.
     - parameter indexTitle: Sets the `sectionIndexTitle`. Default value is `nil`.
     - parameter items: Sets the `items` array.
     
    */
    public init(title: String? = nil, indexTitle: String? = nil, items: [Element]) {
        self.items = items
        self.sectionTitle = title
        self.sectionIndexTitle = indexTitle
    }
    
    /// `CollectionSection` conformance, returns the count of `items`.
    public func numberOfItems() -> Int{
        return items.count
    }
    
    /// `CollectionSection` conformance, returns the object in `items` at the given index.
    public func item(at index: Int) -> Element {
        return items[index]
    }
}

public extension ArraySection where Element: Equatable {
    
    /// Convenience accessor for the index of a given item if the element type of this section is `Equatable`.
    public func index(of: Element) -> Int? {
        return items.index(of: of)
    }
}
