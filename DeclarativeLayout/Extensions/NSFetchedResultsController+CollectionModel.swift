//
//  NSFetchedResultsController+CollectionModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation
import CoreData

public struct NSFetchedResultsCollection<T: Equivalent, NSManagedObject>: CollectionModel {
    
}

extension NSFetchedResultsController: CollectionModel {
    
    public func numberOfSections() -> Int {
        return self.sections?.count ?? 0
    }
    
    public func numberOfItemsInSection(section: Int) -> Int {
        return self.sections?[section].numberOfObjects ?? 0
    }
    
    public func itemAtIndexPath(indexPath: NSIndexPath) -> NSManagedObject {
        return self.objectAtIndexPath(indexPath) as! NSManagedObject
    }
    
    public func titleForSection(section: Int) -> String? {
        return self.sections?[section].name
    }
    
    public func indexTitleForSection(section: Int) -> String? {
        return self.sections?[section].indexTitle
    }
    
    public func indexPathForElement(element: NSManagedObject) -> NSIndexPath? {
        return indexPathForObject(element)
    }
    
    public func modificationsBetween(collection: NSFetchedResultsController) -> CollectionModification {
        
        return CollectionModification()
    }
}