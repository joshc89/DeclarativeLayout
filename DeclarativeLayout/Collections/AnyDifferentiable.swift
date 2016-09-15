//
//  AnyDifferentiable.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 15/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/// Type erased conformance to `CollectionModel`
public class AnyCollection<ElementType>: CollectionModel {
    
    private let _numberOfSections: () -> Int
    private let _numberOfItems: (Int) -> Int
    private let _item: (IndexPath) -> ElementType
    
    private let _title: (Int) -> String?
    private let _indexTitle: (Int) -> String?
    
    public init<Injected: CollectionModel>(collection: Injected) where Injected.Element == ElementType {
        
        _numberOfSections = collection.numberOfSections
        _numberOfItems = collection.numberOfItems
        _item = collection.item
        _title = collection.title
        _indexTitle = collection.indexTitle
    }
    
    public func numberOfSections() -> Int {
        return _numberOfSections()
    }
    
    public func numberOfItems(in section: Int) -> Int {
        return _numberOfItems(section)
    }
    
    public func item(at: IndexPath) -> ElementType {
        return _item(at)
    }
    
    public func title(for section: Int) -> String? {
        return _title(section)
    }
    
    public func indexTitle(for section: Int) -> String? {
        return _indexTitle(section)
    }
}

/*
public class AnyDifferentiableCollection<ElementType>: AnyCollection<ElementType>, DifferentiableCollectionModel {
    
    public typealias Element = ElementType
    
    public override init<Injected: DifferentiableCollectionModel>(collection: Injected) where Injected.Element == Element {
        
        let i: (Injected) -> CollectionModification = collection.modifications
        
        super.init(collection: collection)
    }
    
    // MARK: Differentiable
    
    public func modifications(between: AnyDifferentiableCollection<ElementType>) -> CollectionModification {
        return CollectionModification()
    }
}
*/
