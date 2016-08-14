//
//  TableLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 14/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

public class TableLayout<CollectionType: CollectionModel>: Layout {
    
    // MARK: Properties
    
    /// Convenience accessort for the `tableView` of `manager`.
    var tableView: UITableView {
        return manager.tableView
    }
    
    let manager: TableManager<CollectionType>
    
    // MARK: Initialisers
    
    public init(dataSource: TableManager<CollectionType>) {
        self.manager = dataSource
    }
    
    convenience init(collection: CollectionType, style: UITableViewStyle = .Plain) {
        
        let tbv = UITableView(frame: CGRectZero, style: style)
        let data = TableManager(tableView: tbv, collection: collection)
        self.init(dataSource: data)
    }
    
    // MARK: Layout Conformance
    
    public var boundary: AnchoredObject {
        return tableView
    }
    
    public var elements: [Layout] {
        return [tableView]
    }
}