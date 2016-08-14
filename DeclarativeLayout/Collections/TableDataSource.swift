//
//  TableDataSource.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

// subclass as we are providing explicit delegate behaviour
public class TableManager<CollectionType: CollectionModel>: NSObject, UITableViewDataSource {
    
    // Intended one data source per table view hence `let`
    public let tableView: UITableView
    
    // read-only. use `updateCollection(_:animated:)` as setter instead.
    public private(set) var collection: CollectionType
    
    public init(tableView: UITableView, collection: CollectionType) {
        
        self.collection = collection
        self.tableView = tableView
        
        super.init()
        
        tableView.dataSource = self
    }
    
    public func updateCollection(collection: CollectionType, animated: Bool) {
        
        self.collection = collection
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource Conformance
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return collection.numberOfSections()
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.numberOfItemsInSection(section)
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collection.titleForSection(section)
    }
    
    public func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        let possibleTitles = (0..<collection.numberOfSections()).map { self.collection.indexTitleForSection($0) }
        
        let allAvailable = possibleTitles.reduce(true) { $0 && $1 != nil }
        
        return allAvailable ? possibleTitles.flatMap { $0 } : nil
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell(style: .Default, reuseIdentifier: "CollectionCell")
    }
}

extension TableManager where CollectionType: DifferentiableCollectionModel {
    
    public func updateCollection(collection: CollectionType, animated: Bool) {
        
        let oldValue = self.collection
        self.collection = collection
        
        if animated {
            tableView.applyModification(oldValue.modificationsBetween(collection), animated: animated)
        } else {
            tableView.reloadData()
        }
    }
}
