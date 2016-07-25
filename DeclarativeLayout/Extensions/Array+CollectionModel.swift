//
//  Array+CollectionModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

// TODO: extend generic typealias in Swift 3
// typealias EquivalentArray<T: Equivalent> = Array<T>

extension Array where Element: Equivalent {
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    public func numberOfItemsInSection(section: Int) -> Int {
        return count
    }
    
    public func itemAtIndexPath(indexPath: NSIndexPath) -> Element {
        return self[indexPath.item]
    }
    
    public func titleForSection(section: Int) -> String? {
        return nil
    }
    
    public func indexTitleForSection(section: Int) -> String? {
        return nil
    }

    func indexPath(forIndex: Int) -> NSIndexPath {
        return NSIndexPath(forItem: forIndex, inSection: 0)
    }
    
    func indexPathForElement(element: Element) -> NSIndexPath? {
        return indexOf(element).flatMap { NSIndexPath(forItem: $0, inSection: 0) }
    }
    
    func modificationsBetween(collection: [Element]) -> CollectionModification {
        
//        let newRange: Range = 0..<collection.count
        var inserts = Set(0..<collection.count)  // removed on iteration if present in both collections
        var deletes = [NSIndexPath]()
        var moves = [(from: NSIndexPath, to: NSIndexPath)]()
        var reloads = [NSIndexPath]()
        
        // calculate
        
        for (idx, element) in self.enumerate() {
         
            if let newIdx = collection.indexOf(element) {
                
                // this isn't a new element
                inserts.remove(newIdx)
                
                if newIdx == idx {
                    
                    if !element.equivalentTo(collection[newIdx]) {
                        reloads.append(indexPath(idx))
                    }
                    
                } else {
                    moves.append( (from: indexPath(idx), to: indexPath(newIdx)) )
                }
                
            } else {
                deletes.append(indexPath(idx))
            }
        }
        
        return CollectionModification(rowInsertions: inserts.map { self.indexPath($0) },
                                      rowDeletions: deletes,
                                      rowMoves: moves,
                                      rowReloads: reloads)
    }
    
}