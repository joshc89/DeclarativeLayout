//
//  NSFetchedResultsController+CollectionModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation
import CoreData

// TODO: Segmentation Fault causes commented code to fail :(

extension NSFetchedResultsController { // : CollectionModel {
    
    // public typealias Element = ResultType
    
    public func numberOfSections() -> Int {
        return 0 //sections?.count ?? 0
    }
    
    public func numberOfItems(in section: Int) -> Int {
        return 0 // self.sections?[section].numberOfObjects ?? 0
    }

    public func item(at indexPath: IndexPath) -> ResultType {
        return object(at: indexPath)
    }

    public func title(for section: Int) -> String? {
        return self.sections?[section].name
    }

    public func indexTitle(for section: Int) -> String? {
        return self.sections?[section].indexTitle
    }

}
