//
//  DifferentiableCollectionModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 14/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

public protocol DifferentiableCollectionModel: CollectionModel {
    
    // func indexPath(of: Element) -> IndexPath?
    
    func modifications(toBecome: Self) -> CollectionModification
}

public struct CollectionModification {
    
    let rowInsertions: [IndexPath]
    
    let rowDeletions: [IndexPath]
    
    let rowMoves: [(from: IndexPath, to: IndexPath)]
    
    let rowReloads: [IndexPath]
    
    let sectionInsertions: NSIndexSet
    
    let sectionDeletions: NSIndexSet
    
    let sectionMoves: [(from: Int, to: Int)]
    
    let sectionReloads: NSIndexSet
    
    public init(rowInsertions: [IndexPath] = [],
                rowDeletions: [IndexPath] = [],
                rowMoves: [(from: IndexPath, to: IndexPath)] = [],
                rowReloads: [IndexPath] = [],
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

public extension DifferentiableCollectionModel {
    /*
     func modificationsBetween<CollectionType: CollectionModel where CollectionType.Element == Element>(collection: CollectionType) -> CollectionModification {
     
     let (mySections, myCounts) = self.counts()
     let (thierSections, theirCounts) = collection.counts()
     
     var inserts = [[IndexPath]](minimumCapacity: totalSections)
     
     for (section, count) in counts.enumerate() {
     let paths = (0..<count).map { IndexPath(item: $0, section: section) }
     inserts.append(paths)
     }
     
     var deletes = [IndexPath]()
     var moves = [(from: IndexPath, to: IndexPath)]()
     var reloads = [IndexPath]()
     
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
