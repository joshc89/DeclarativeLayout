//
//  TableDataSource.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

open class DifferentiableTableManager<DifferentiableType: DifferentiableCollectionModel> : TableManager<DifferentiableType> {
    
    public override func update(to: DifferentiableType, animated: Bool) {
        
        let modifications = collection.modifications(toBecome: to)
        self.collection = to
        tableView.applyModification(modifications: modifications, animated: animated)
    }
}

// subclass as we are providing explicit delegate behaviour
open class TableManager<CollectionType: CollectionModel>: NSObject, UITableViewDataSource {
    
    // Intended one data source per table view hence `let`
    public let tableView: UITableView
    
    /// It is recommended that only subclasses set this variable. Use `update(to:animated)` as setter instead.
    public var collection: CollectionType
    
    public init(tableView: UITableView, collection: CollectionType) {
        
        self.collection = collection
        self.tableView = tableView
        
        super.init()
        
        tableView.dataSource = self
    }
    
    public func update(to: CollectionType, animated: Bool) {
        
        self.collection = to
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource Conformance
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return collection.numberOfSections()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return collection.numberOfItems(in: section)
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return collection.title(for: section)
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        let possibleTitles = (0..<collection.numberOfSections()).map { self.collection.indexTitle(for: $0) }
        
        let allAvailable = possibleTitles.reduce(true) { $0 && $1 != nil }
        
        return allAvailable ? possibleTitles.flatMap { $0 } : nil
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell(style: .default, reuseIdentifier: "CollectionCell")
    }
    
}
