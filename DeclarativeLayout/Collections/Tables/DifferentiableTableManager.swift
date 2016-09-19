//
//  DifferentiableTableManager.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 16/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/// `TableManager` subclass for a `DifferentiableCollectionModel` that can be used to animate between two states using a `CollectionModification`.
open class DifferentiableTableManager<DifferentiableType: DifferentiableCollectionModel> : TableManager<DifferentiableType> {
    
    /**
     
     Method for updating the data in the table. Calculates a `Collectionmodication` between the current `collection` and new value to apply to the table.
     
     - note: If you know the modification to be applied (such as in response to an update in model from CoreData) then it can be more efficient to set `self.collection` and call `tableView.apply(modifications:animated)` manually.
     
     - parameter to: A new version of the data to show.
     - parameter animated: Flag for whether the change should be animated or whether the data should just be reloaded.
     
     - seealso: `tableView.apply(modifications:animated:)`
     
     */
    open override func update(to: DifferentiableType, animated: Bool) {
        let modifications = collection.modifications(toBecome: to)
        self.collection = to
        tableView.apply(modifications: modifications, animated: animated)
    }
}
