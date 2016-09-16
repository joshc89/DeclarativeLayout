//
//  TableLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 14/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Simple layout that includes a table populated by a `TableManager`.
public class TableLayout<CollectionType: CollectionModel>: Layout {
    
    // MARK: Properties
    
    /// Convenience accessor for the `tableView` of `manager`.
    var tableView: UITableView {
        return manager.tableView
    }
    
    /// The object that is managing this table.
    let manager: TableManager<CollectionType>
    
    // MARK: Initialisers
    
    /// Declarative initialiser of a table and its data source.
    public init(dataSource: TableManager<CollectionType>) {
        self.manager = dataSource
    }
    
    // MARK: Layout Conformance
    
    /**
     
     `Layout` conformance.
     
     - returns: `tableView`.
     
    */
    public var boundary: AnchoredObject {
        return tableView
    }
    
    /**
     
     `Layout` conformance.
     
     - returns: An array of just `tableView`.
     
     */
    public var elements: [Layout] {
        return [tableView]
    }
}
