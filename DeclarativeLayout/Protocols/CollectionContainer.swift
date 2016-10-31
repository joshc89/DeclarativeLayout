//
//  CollectionContainer.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 16/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/**
 
 Convenience type that defines a container of a `CollectionModel` and provides default implementations for each of the protocol methods to forward them to the contained `collection`. 
 
 This is useful for objects that hold a `CollectionModel`, such as a View Model that performs a network request a retains the result of that request.
 
 - note: The current version of Swift does not allow for a protocol to have an inheritance clause, hence this protocol extends `CollectionModel`.
 
 */
public protocol CollectionContainer: CollectionModel {
    
    /// The type of `CollectionModel` that this object contains.
    associatedtype CollectionType: CollectionModel
    
    var collection: CollectionType { get }
}

/// MARK: CollectionModel Conformance
public extension CollectionContainer where Element == CollectionType.Element {
    
    /// `CollectionModel` conformance. Forwards the request to `collection`.
    public func numberOfSections() -> Int {
        return collection.numberOfSections()
    }
    
    /// `CollectionModel` conformance. Forwards the request to `collection`.
    public func numberOfItems(in section: Int) -> Int {
        return collection.numberOfItems(in: section)
    }
    
    /// `CollectionModel` conformance. Forwards the request to `collection`.
    public func item(at indexPath: IndexPath) -> Element {
        return collection.item(at: indexPath)
    }
    
    /// `CollectionModel` conformance. Forwards the request to `collection`.
    public func title(forSection: Int) -> String? {
        return collection.title(forSection: forSection)
    }
    
    /// `CollectionModel` conformance. Forwards the request to `collection`.
    public func indextitle(forSection: Int) -> String? {
        return collection.indexTitle(forSection: forSection)
    }
}


