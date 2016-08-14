//
//  ModelsViewController.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 14/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

import DeclarativeLayout

extension CarManufacturer: CollectionSection {
    
    var sectionTitle: String? {
        return name
    }
    
    var sectionIndexTitle: String? {
        return name.substringToIndex(name.startIndex.advancedBy(1))
    }

    func numberOfItems() -> Int {
        return models.count
    }
    
    func itemAtIndex(index: Int) -> CarModel {
        return models[index]
    }
}

/// Demo class for using the TableManager as a data source
class ModelsViewController: UITableViewController {
    
    let cars:Collection<CarManufacturer>
    let loader = CarLoader()
    var manager: CarTableManager!
    
    init() {
        
        // force the load as failure implies a problem with the json / bundle which represents a programmer error.
        let carSections = try! loader.loadData()
        cars = Collection(sections: carSections)
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
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CarModel") ?? UITableViewCell(style: .Subtitle, reuseIdentifier: "CarModel")
            
            let model = self.collection.itemAtIndexPath(indexPath)
            
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = model.basePrice
            
            return cell
        }
        
        
    }
}
