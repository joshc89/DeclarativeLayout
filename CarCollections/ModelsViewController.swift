//
//  ModelsViewController.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 14/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

import DeclarativeLayout

/// Extend the model to define a section within a table.
extension CarManufacturer: CollectionSection {
    
    /**
     
     `CollectionSection` conformance
     
     - returns: `name`
     
     */
    var sectionTitle: String? {
        return name
    }
    
    /**
     
     `CollectionSection` conformance
     
     - returns: The first character from `name`.
     */
    var sectionIndexTitle: String? {
        return name.substringToIndex(name.startIndex.advancedBy(1))
    }
    
    /**
     
     `CollectionSection` conformance
     
     - returns: The number of elements in of `models`.
     */
    func numberOfItems() -> Int {
        return models.count
    }
    
    /**
     
     `CollectionSection` conformance
     
     - returns: the `CarModel` at the given `index` in `models`.
     */
    func itemAtIndex(index: Int) -> CarModel {
        return models[index]
    }
}

/// Demo class for using the TableManager as a data source
class ModelsViewController: UITableViewController {
    
    /// 'ViewModel' for this view that is responsible for the logic behind creating the data for the table.
    let loader = CarLoader()
    
    /// The manager for `tableView`. This represents the data source for the table
    var manager: CarTableManager!
    
    
    
    /// Default initialiser. Force loads the sections synchronously for this simple example.
    init() {
        
        // force the load as failure implies a problem with the json / bundle which represents a programmer error.
        let carSections = try! loader.loadData()
        let cars = Collection(sections: carSections)
        super.init(style: .Plain)
        
        manager = CarTableManager(tableView: tableView, collection: cars)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Data Source
    
    class CarTableManager: TableManager<Collection<CarManufacturer>> {
        
        override init(tableView: UITableView, collection: Collection<CarManufacturer>) {
            super.init(tableView: tableView, collection: collection)
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CarModel") ?? UITableViewCell(style: .Subtitle, reuseIdentifier: "CarModel")
            
            let model = self.collection.itemAtIndexPath(indexPath)
            
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = model.basePrice
            
            return cell
        }
        
        
    }
}
