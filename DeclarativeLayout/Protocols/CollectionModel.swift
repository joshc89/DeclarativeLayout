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

public struct CollectionModification {
    
    let rowInsertions: [NSIndexPath]
    
    let rowDeletions: [NSIndexPath]
    
    let rowMoves: [(from: NSIndexPath, to: NSIndexPath)]
    
    let rowReloads: [NSIndexPath]

    let sectionInsertions: NSIndexSet
    
    let sectionDeletions: NSIndexSet
    
    let sectionMoves: [(from: Int, to: Int)]
    
    let sectionReloads: NSIndexSet
    
    public init(rowInsertions: [NSIndexPath] = [],
                rowDeletions: [NSIndexPath] = [],
                rowMoves: [(from: NSIndexPath, to: NSIndexPath)] = [],
                rowReloads: [NSIndexPath] = [],
                sectionInsertions: NSIndexSet = NSIndexSet(),
                sectionDeletions: NSIndexSet = NSIndexSet(),
                sectionMoves: [(from: Int, to: Int)] = [],
                sectionReloads: NSIndexSet = NSIndexSet()) {
        
        self.rowInsertions = rowInsertions
        self.rowDeletions = rowDeletions
        self.rowMoves = rowMoves
        self.rowReloads = rowReloads
        
        self.sectionInsertions = sectionInsertions
        self.sectionDeletions = sectionDeletions
        self.sectionMoves = sectionMoves
        self.sectionReloads = sectionReloads
    }
}

public protocol CollectionModel {
    
    associatedtype Element: Equivalent
    
    // MARK: Population
    
    func numberOfSections() -> Int
    
    func numberOfItemsInSection(section: Int) -> Int
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> Element
    
    // MARK: Supplementary
    
    func titleForSection(section: Int) -> String?
    
    func indexTitleForSection(section: Int) -> String?
    
    // MARK: Updates
    
    func indexPathForElement(element: Element) -> NSIndexPath?
    
    func modificationsBetween(collection: Self) -> CollectionModification
}

public extension CollectionModel {
    
    public func counts() -> (totalSections: Int, sectionCounts: [Int]) {
        let totalSections = numberOfSections()
        let counts = (0..<totalSections)
            .map { self.numberOfItemsInSection($0) }
    }
    
    /*
    func modificationsBetween<CollectionType: CollectionModel where CollectionType.Element == Element>(collection: CollectionType) -> CollectionModification {
        
        let (mySections, myCounts) = self.counts()
        let (thierSections, theirCounts) = collection.counts()
        
        var inserts = [[NSIndexPath]](minimumCapacity: totalSections)
        
        for (section, count) in counts.enumerate() {
            let paths = (0..<count).map { NSIndexPath(forItem: $0, inSection: section) }
            inserts.append(paths)
        }
        
        var deletes = [NSIndexPath]()
        var moves = [(from: NSIndexPath, to: NSIndexPath)]()
        var reloads = [NSIndexPath]()
        
        // calculate
        
        for s in 0..<mySections {
            for r in 0..<myCounts[s] {
                
                if let theirIdx = collection.indexPathForElement(element) {
                    
                    // this isn't a new element
                    inserts[s] = inserts[s]
                    
                    if newIdx == idx {
                        
                        if !element.equivalentTo(collection[newIdx]) {
                            reloads.append(indexPath(idx))
                        }
                        
                    } else {
                        moves.append( (from: indexPath(idx), to: indexPath(newIdx)) )
                    }
                    
                } else {
                    deletions.append(NSI)
                }
            }
        }
        
        return CollectionModification(rowInsertions: inserts.map { self.indexPath($0) },
                                      rowDeletions: deletes,
                                      rowMoves: moves,
                                      rowReloads: reloads)
    }
    */
    
}

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
