//
//  TableDataSource.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/**
 
 Common `UITableViewDataSource` that implements common methods using a generic `CollectionModel`. Typical use is to subclass this, providing explicit cell creation.

 Methods implemented are:
 
 - `numberOfSection(in:)`
 - `tableView(_:numberOfRowsInSection:)`
 - `tableView(_:titleForHeaderInSection:)`
 - `sectionIndexTitles(for:)`
 
 `tableView(_:cellForRowAt:)` is implemented to return a new `UITableViewCell`. Subclasses should override this to return the configured cell for their object. Ensure this cell is registered programmatically in `init()` if the `tableView` hasn't been created from a Storyboard.
 
*/
open class TableManager<CollectionType: CollectionModel>: NSObject, UITableViewDataSource {
    
    /// The `UITableView` this object is managing. The intention is one table view per manager, hence `let`
    public let tableView: UITableView
    
    /// It is recommended that only subclasses set this variable. Use `update(to:animated)` to provide new data instead.
    open var collection: CollectionType
    
    /**
     
     Default initialiser, assigns `self` as the data source for this `UITableView`.
     
     - note: Animation is supported only using a `DifferentiableTableManager`.
     
     - parameter tableView: The table to manage.
     - parameter collection: The initial data for this table. This can be updated subsequently using `update(to:animated:)`.
     
    */
    public init(tableView: UITableView, collection: CollectionType) {
        
        self.collection = collection
        self.tableView = tableView
        
        super.init()
        
        tableView.dataSource = self
    }
    
    /**
     
     Recommended method for updating the data in the table. 
     
     - note: This class does not perform the update with animation. Use `DifferentiableTableManager` instead.
     
     - parameter to: A new version of the data to show.
     - parameter animated: Flag unused in this class. See `DifferentiableTableManager` instead.
     
    */
    open func update(to: CollectionType, animated: Bool) {
        
        self.collection = to
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource Conformance
    
    /**
     
     `UITableViewDataSource` conformance.
     
     - returns: The `numberOfSections()` of `collection`.
     
     */
    open func numberOfSections(in tableView: UITableView) -> Int {
        return collection.numberOfSections()
    }
    
    /**
     
     `UITableViewDataSource` conformance.
     
     - returns: The `numberOfItems(in:) collection`.
     
     */
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return collection.numberOfItems(in: section)
    }
    
    /**
     
     `UITableViewDataSource` conformance.
     
     - returns: The `title(for:) collection`.
     
     */
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return collection.title(forSection: section)
    }
    
    /**
     
     `UITableViewDataSource` conformance.
     
     - returns: An array resulting from `collection.indexTitle(for:)` for each section index. If an index title is missing for a section, `nil` is returned.
     
     */
    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        let possibleTitles = (0..<collection.numberOfSections()).map { self.collection.indexTitle(forSection: $0) }
        
        let allAvailable = possibleTitles.reduce(true) { $0 && $1 != nil }
        
        return allAvailable ? possibleTitles.flatMap { $0 } : nil
    }
    
    /**
     
     `UITableViewDataSource` conformance. Subclasses should override this method to provide a custom cell, typically populated using `collection.item(at:)`.
     
     - returns: A `.default UITableViewCell`.
     
    */
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell(style: .default, reuseIdentifier: "CollectionCell")
    }
    
}
