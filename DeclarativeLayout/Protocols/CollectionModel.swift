//
//  CollectionModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

public protocol Equivalent: Equatable {
    
    func equivalent(to: Self) -> Bool
    
}

public protocol CollectionModel {
    
    associatedtype Element
    
    // MARK: Population
    
    func numberOfSections() -> Int
    
    func numberOfItems(in: Int) -> Int
    
    func item(at: IndexPath) -> Element
    
    // MARK: Supplementary
    
    func title(for: Int) -> String?
    
    func indexTitle(for: Int) -> String?
    
}

public protocol CollectionSection {
    
    associatedtype Element
    
    func numberOfItems() -> Int
    
    func item(at: Int) -> Element
    
    var sectionTitle: String? { get }
    
    var sectionIndexTitle: String? { get }
}

// MARK: Container

public protocol CollectionContainer: CollectionModel {
    
    associatedtype CollectionType: CollectionModel
    
    var collection: CollectionType { get }
}

public extension CollectionContainer where Element == CollectionType.Element {
    
    public func numberOfSections() -> Int {
        return collection.numberOfSections()
    }
    
    public func numberOfItems(in section: Int) -> Int {
        return collection.numberOfItems(in: section)
    }
    
    public func item(at indexPath: IndexPath) -> Element {
        return collection.item(at: indexPath)
    }
    
    public func title(for section: Int) -> String? {
        return collection.title(for: section)
    }
    
    public func indexTitle(for section: Int) -> String? {
        return collection.indexTitle(for: section)
    }
}


public extension CollectionModel {
    
    public func counts() -> (totalSections: Int, sectionCounts: [Int]) {
        let totalSections = numberOfSections()
        let counts = (0..<totalSections)
            .map { self.numberOfItems(in: $0) }
        
        return (totalSections, counts)
    }
}
