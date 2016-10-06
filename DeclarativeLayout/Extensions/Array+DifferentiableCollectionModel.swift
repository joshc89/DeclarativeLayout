//
//  Array+DifferentiableCollectionModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 14/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

// MARK: Single Section Differentiable

public extension Array where Element: Equatable {
    
    public func indexPathForElement(element: Element) -> IndexPath? {
        
        
        
        return index(of: element).flatMap { IndexPath(item: $0, section: 0) }
    }
}

extension IndexPath {
    
    init(item: Int) {
        self.init(item: item, section: 0)
    }
    
    init(row: Int) {
        self.init(row: row, section: 0)
    }
}

public extension Array where Element: Equivalent {
    
    public func modificationsBetween(collection: [Element]) -> CollectionModification {
        
        //        let newRange: Range = 0..<collection.count
        var inserts = Set(0..<collection.count)  // removed on iteration if present in both collections
        var deletes = [IndexPath]()
        var moves = [(from: IndexPath, to: IndexPath)]()
        var reloads = [IndexPath]()
        
        // calculate
        
        for (idx, element) in self.enumerated() {
            
            if let newIdx = collection.index(of: element) {
                
                // this isn't a new element
                inserts.remove(newIdx)
                
                if newIdx == idx {
                    
                    if !element.equivalent(to: collection[newIdx]) {
                        reloads.append(IndexPath(item: idx))
                    }
                    
                } else {
                    moves.append( (from: IndexPath(item: idx), to: IndexPath(item: newIdx)) )
                }
                
            } else {
                deletes.append(IndexPath(item: idx))
            }
        }
        
        return CollectionModification(rowInsertions: inserts.map { IndexPath(item: $0) },
                                      rowDeletions: deletes,
                                      rowMoves: moves,
                                      rowReloads: reloads)
    }
    
}
