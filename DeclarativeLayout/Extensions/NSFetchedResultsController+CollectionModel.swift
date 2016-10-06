//
//  NSFetchedResultsController+CollectionModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation
import CoreData

/**
 
 Struct wrapping an `NSFetchedResultsController` to use as a `CollectionModel`. 
 
 - note: An extension would be preferred to this wrapper however a segementation fault in the current version of Xcode prevents the framework from compiling.
 
*/
struct FetchedCollection<Element: NSManagedObject>: CollectionModel {
    
    let fetchController: NSFetchedResultsController<Element>
    
    init(controller: NSFetchedResultsController<Element>) {
        fetchController = controller
    }
    
    public func numberOfSections() -> Int {
         return fetchController.sections?.count ?? 0
    }
    
    public func numberOfItems(in section: Int) -> Int {
        return fetchController.sections?[section].numberOfObjects ?? 0
    }
    
    public func item(at indexPath: IndexPath) -> Element {
        return fetchController.object(at: indexPath)
    }
    
    public func title(forSection: Int) -> String? {
        return fetchController.sections?[forSection].name
    }
    
    public func indextitle(forSection: Int) -> String? {
        return fetchController.sections?[forSection].indexTitle
    }

}

/*
// TODO: Segmentation Fault causes this extension code to fail :(
extension NSFetchedResultsController { // : CollectionModel {
    
    // public typealias Element = ResultType
    
    public func numberOfSections() -> Int {
        
        if let s = sections {
            return s.count
        } else {
            return 0
        }
        
        // This *should* work but Xcode 8.0 generates a Segmentation Fault
        // return sections?.count ?? 0
    }
    
    public func numberOfItems(in section: Int) -> Int {
        return 0 // self.sections?[section].numberOfObjects ?? 0
    }

    public func item(at indexPath: IndexPath) -> ResultType {
        return object(at: indexPath)
    }

    public func title(forSection: Int) -> String? {
        return self.sections?[forSection].name
    }

    public func indextitle(forSection: Int) -> String? {
        return self.sections?[forSection].indexTitle
    }
}
*/
