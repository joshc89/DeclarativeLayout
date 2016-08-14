//
//  ArrayCollection.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 07/08/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

public struct Collection<SectionType: CollectionSection>: CollectionModel {
    
    public let sections: [SectionType]
    
    public init(sections: [SectionType]) {
        self.sections = sections
    }
    
    public func numberOfSections() -> Int {
        return sections.count
    }
    
    public func numberOfItemsInSection(section: Int) -> Int {
        return sections[section].numberOfItems()
    }
    
    public func titleForSection(section: Int) -> String? {
        return sections[section].sectionTitle
    }
    
    public func indexTitleForSection(section: Int) -> String? {
        return sections[section].sectionIndexTitle
    }
    
    public func itemAtIndexPath(indexPath: NSIndexPath) -> SectionType.Element {
        return sections[indexPath.section].itemAtIndex(indexPath.row)
    }
}

public struct ArraySection<Element>: CollectionSection {
 
    public let items: [Element]
    
    public let sectionTitle: String?
    
    public let sectionIndexTitle: String?
    
    public init(items: [Element], title: String?, indexTitle: String?) {
        self.items = items
        self.sectionTitle = title
        self.sectionIndexTitle = indexTitle
    }
    
    public func numberOfItems() -> Int{
        return items.count
        
        
    }
    
    public func itemAtIndex(index: Int) -> Element {
        return items[index]
    }
}

