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
        return name.substring(to: name.characters.index(name.startIndex, offsetBy: 1))
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
    func item(at: Int) -> CarModel {
        return models[at]
    }
}

/// Demo class for using the TableManager as a data source on an existing table view
class ModelsViewController: UITableViewController {
    
    /// 'ViewModel' for this view that is responsible for the logic behind creating the data for the table.
    let loader = CarLoader()
    
    /// The manager for `tableView`. This represents the data source for the table
    var manager: CarTableManager!
    
    
    /// Default initialiser. Force loads the sections synchronously for this simple example.
    init() {
        
        // force the load as failure implies a problem with the json / bundle which represents a programmer error.
        let carSections = (try? loader.loadData()) ?? []
        let cars = ArrayCollection(sections: carSections)
        super.init(style: .plain)
        
        manager = CarTableManager(tableView: tableView, collection: cars)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Data Source

class CarTableManager: TableManager<ArrayCollection<CarManufacturer> > {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarModel") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "CarModel")
        
        let model = collection.item(at: indexPath)
        
        cell.textLabel?.text = model.name
        cell.detailTextLabel?.text = model.basePrice
        
        return cell
    }
}

