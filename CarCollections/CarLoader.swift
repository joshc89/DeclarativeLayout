//
//  CarLoader.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 14/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

enum Result<T> {
 
    case success(T)
    case failure(Error)
}

class CarLoader {
    
    let jsonURL = Bundle.main.url(forResource: "CarModels", withExtension: "json")!
    
    /// *Synchronously* loads all of the car models from the local json file
    func loadData() throws -> [CarManufacturer] {
        
        let data = try Data(contentsOf: jsonURL)
        
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: AnyObject]]
            else {
                return []
        }
        
        return json.flatMap { CarManufacturer(json: $0) }
    }

    func loadDataInBackground(delay: Double = 0.5, _ completion: @escaping (Result<[CarManufacturer]>) -> ()) {
        
        let task = URLSession.shared.dataTask(with: jsonURL) { (data, _, error) in
            
            if let d = data {
                
                do {
                    let encoded = try JSONSerialization.jsonObject(with: d, options: .allowFragments)
                    
                    if let jsonDefinitions = encoded as? [[String: AnyObject]] {
                        let manufacturers = jsonDefinitions.flatMap { CarManufacturer(json: $0) }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                            completion(.success(manufacturers))
                        }
                        
                    } else {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                            completion(.failure(LoadError.incorrectJSON))
                        }
                    }
                    
                } catch let error {
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        completion(.failure(error))
                    }
                }
                
            } else if let e = error {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    completion(.failure(e))
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    completion(.failure(LoadError.loadFailed))
                }
            }
            
        }
        
        task.resume()
    }
    
    enum LoadError: Error {
        
        case incorrectJSON
        case invalidJSON
        case loadFailed
        
        var localizedDescription: String {
            switch self {
            case .invalidJSON:
                return "Invalid json in file."
            case .incorrectJSON:
                return "Incorrect json format."
            case .loadFailed:
                return "Failed to load file."
            }
        }
    }
}
