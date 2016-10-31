//
//  CollectionModification.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 16/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/**
 
 Struct that can be used to encapsulate the changes that can be applied to one collection to transform it to another.
 
 - seealso: `UITableView`.`apply(modifications:animated:)`
 
 */
public struct CollectionModification {
    
    /// The `IndexPath`s of items to be inserted.
    let rowInsertions: [IndexPath]
    
    /// The `IndexPath`s of items to be deleted.
    let rowDeletions: [IndexPath]
    
    /// Pairs of `IndexPath`s for the rows to be moved.
    let rowMoves: [(from: IndexPath, to: IndexPath)]
    
    /// The `IndexPath`s of items to be reloaded, typically because they represent a model object that has been updated.
    let rowReloads: [IndexPath]
    
    /// The indexes of entire sections to be inserted.
    let sectionInsertions: IndexSet
    
    /// The indexes of entire sections to be deleted.
    let sectionDeletions: IndexSet
    
    /// Pairs of indexes for the entire sections to be moved.
    let sectionMoves: [(from: Int, to: Int)]
    
    /// The indexes of entire sections to be reloaded.
    let sectionReloads: IndexSet
    
    /**
     
     Default initialiser setting all properties. Each has a default value of an empty Array or IndexSet as appropriate.
     
    */
    public init(rowInsertions: [IndexPath] = [],
                rowDeletions: [IndexPath] = [],
                rowMoves: [(from: IndexPath, to: IndexPath)] = [],
                rowReloads: [IndexPath] = [],
                sectionInsertions: IndexSet = IndexSet(),
                sectionDeletions: IndexSet = IndexSet(),
                sectionMoves: [(from: Int, to: Int)] = [],
                sectionReloads: IndexSet = IndexSet()) {
        
        self.rowInsertions = rowInsertions
        self.rowDeletions = rowDeletions
        self.rowMoves = rowMoves
        self.rowReloads = rowReloads
        
        self.sectionInsertions = sectionInsertions
        self.sectionDeletions = sectionDeletions
        self.sectionMoves = sectionMoves
        self.sectionReloads = sectionReloads
    }
    
    /**
     
     Convenience method for creating the opposite of a modification. This can be used to create an undo stack for a series of changes to a collection.
     
     - returns: The modification the would return the collection resulting from this modification to its original state.
     
    */
    func makeInverse() -> CollectionModification {
        
        return CollectionModification(rowInsertions: rowDeletions,
                                      rowDeletions: rowInsertions,
                                      rowMoves: rowMoves.map { ($0.to, $0.from) },
                                      rowReloads: rowReloads,
                                      sectionInsertions: sectionDeletions,
                                      sectionDeletions: sectionInsertions,
                                      sectionMoves: sectionMoves.map { ($0.to, $0.from) },
                                      sectionReloads: sectionReloads)
    }
}
