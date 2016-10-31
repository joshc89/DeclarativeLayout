//
//  CollectionSection.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 16/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/**
 
 Protocol defining requirements for a section within a list.
 
 - seealso: `ArrayCollection`
 - seealso: `ArraySection`
 
 */
public protocol CollectionSection {
    
    /// The type of item in this section.
    associatedtype Element
    
    /// The number of items in this section of the list.
    func numberOfItems() -> Int
    
    /// The item at a given index in the list
    func item(at: Int) -> Element
    
    /// The title for this section.
    var sectionTitle: String? { get }
    
    /// The index title for this section.
    var sectionIndexTitle: String? { get }
}
