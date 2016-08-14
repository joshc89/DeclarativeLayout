//
//  CarModel.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 14/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

struct CarManufacturer {
    
    let name: String
    
    let logoURL: NSURL?
    
    let models: [CarModel]
}

extension CarManufacturer {
    
    init?(json: [String: AnyObject]) {
        
        guard let name = json["manufacturer"] as? String,
            let logoModels = json["models"] as? [[String: AnyObject]]
            else {
                return nil
        }
        
        let models = logoModels.flatMap { CarModel(json: $0) }
        
        let url = (json["logo_url"] as? String).flatMap { NSURL(string: $0) }
        
        self.init(name: name, logoURL: url, models: models)
    }
    
}

struct CarModel {
    
    let name: String
    let thumbnailURL: NSURL?
    let basePrice: String
    
}

extension CarModel {
    
    init?(json: [String: AnyObject]) {
        
        guard let name = json["name"] as? String,
            let price = json["base_price"] as? String
            else {
                return nil
        }
        
        let url = (json["thumbnail_url"] as? String).flatMap { NSURL(string: $0) }
        
        self.init(name: name, thumbnailURL: url, basePrice: price)
    }
    
}