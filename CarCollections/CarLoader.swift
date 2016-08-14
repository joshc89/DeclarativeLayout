//
//  CarLoader.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 14/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

class CarLoader {
    
    /// *Synchronously* loads all of the car models from the local json file
    func loadData() throws -> [CarManufacturer] {
        
        guard let jsonURL = NSBundle.mainBundle().URLForResource("CarModels", withExtension: "json"),
            let data = NSData(contentsOfURL: jsonURL),
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]]
            else {
                return []
        }
        
        return json.flatMap { CarManufacturer(json: $0) }
    }

    
}