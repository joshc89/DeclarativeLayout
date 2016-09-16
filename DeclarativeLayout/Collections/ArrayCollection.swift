//
//  ArrayCollection.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 07/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation


public struct ArrayCollection<SectionType: CollectionSection>: CollectionModel {
    
    public let sections: [SectionType]
    
    public init(sections: [SectionType]) {
        self.sections = sections
    }
    
    public func numberOfSections() -> Int {
        return sections.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        return sections[section].numberOfItems()
    }
    
    public func title(forSection: Int) -> String? {
        return sections[forSection].sectionTitle
    }
    
    public func indextitle(forSection: Int) -> String? {
        return sections[forSection].sectionIndexTitle
    }
    
    public func item(at indexPath: IndexPath) -> SectionType.Element {
        return sections[indexPath.section].item(at: indexPath.row)
    }
}

public struct ArraySection<Element>: CollectionSection {
 
    public let items: [Element]
    
    public let sectionTitle: String?
    
    public let sectionIndexTitle: String?
    
    public init(title: String?, indexTitle: String?, items: [Element]) {
        self.items = items
        self.sectionTitle = title
        self.sectionIndexTitle = indexTitle
    }
    
    public func numberOfItems() -> Int{
        return items.count
    }
    
    public func item(at index: Int) -> Element {
        return items[index]
    }
}

