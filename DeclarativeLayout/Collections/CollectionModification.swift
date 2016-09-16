//
//  CollectionModification.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 16/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

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
