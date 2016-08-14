//
//  CollectionModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

public protocol Equivalent: Equatable {
    
    func equivalentTo(to: Self) -> Bool
    
}

public protocol CollectionModel {
    
    associatedtype Element
    
    // MARK: Population
    
    func numberOfSections() -> Int
    
    func numberOfItemsInSection(section: Int) -> Int
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> Element
    
    // MARK: Supplementary
    
    func titleForSection(section: Int) -> String?
    
    func indexTitleForSection(section: Int) -> String?
    
}

public protocol CollectionSection {
    
    associatedtype Element
    
    func numberOfItems() -> Int
    
    func itemAtIndex(index: Int) -> Element
    
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
    
    public func numberOfItemsInSection(section: Int) -> Int {
        return collection.numberOfItemsInSection(section)
    }
    
    public func itemAtIndexPath(indexPath: NSIndexPath) -> Element {
        return collection.itemAtIndexPath(indexPath)
    }
}


public extension CollectionModel {
    
    public func counts() -> (totalSections: Int, sectionCounts: [Int]) {
        let totalSections = numberOfSections()
        let counts = (0..<totalSections)
            .map { self.numberOfItemsInSection($0) }
        
        return (totalSections, counts)
    }
}