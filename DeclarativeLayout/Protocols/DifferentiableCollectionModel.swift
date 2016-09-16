//
//  DifferentiableCollectionModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 14/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

public protocol Equivalent: Equatable {
    func equivalent(to: Self) -> Bool
}

/// Protocol defining the requires of a `CollectionModel` that can calculate a `CollectionModel` between itself and another object of the same type.
public protocol DifferentiableCollectionModel: CollectionModel {
    
    // func indexPath(of: Element) -> IndexPath?
    
    /// Should calculate and return the `CollectionModification` that when applied to self, would result in `toBecome`.
    func modifications(toBecome: Self) -> CollectionModification
}

public extension DifferentiableCollectionModel {
    
    // for sections & rows:
    
    // calculate insertions
    // calculate deletions
    // calculate moves
    // calculate reloads
    
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
