//
//  CollectionManager.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 19/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/**
 
 Common `UICollectionViewDataSource` that implements common methods using a generic `CollectionModel`. Typical use is to subclass this, providing explicit cell creation.
 
 Methods implemented are:
 
 - `numberOfSection(in:)`
 - `collectionView(_:numberOfItemsInSection:)`
 
 `collectionView(_:cellForItemAt:)` is implemented to return a new `UICollectionViewCell`. Subclasses should override this to return the configured cell for their object. Ensure this cell is registered programmatically in `init()` if the `collectionView` hasn't been created from a Storyboard.
 
 */
open class CollectionManager<CollectionType: CollectionModel>: NSObject, UICollectionViewDataSource {
    
    /// The `UICollectionView` this object is managing. The intention is one table view per manager, hence `let`
    public let collectionView: UICollectionView
    
    /// It is recommended that only subclasses set this variable. Use `update(to:animated)` to provide new data instead.
    open var collection: CollectionType
    
    /**
     
     Default initialiser, assigns `self` as the data source for this `UICollectionView`.
     
     - note: Animation is supported only using a `DifferentiableCollectionManager`.
     
     - parameter collectionView: The `UICollectionView` to manage.
     - parameter collection: The initial data for this table. This can be updated subsequently using `update(to:animated:)`.
     
     */
    public init(collectionView: UICollectionView, collection: CollectionType) {
        
        self.collectionView = collectionView
        self.collection = collection
        
        super.init()
        
        collectionView.dataSource = self
    }
    
    /**
     
     Recommended method for updating the data in the table.
     
     - note: This class does not perform the update with animation. Use `DifferentiableCollectionManager` instead.
     
     - parameter to: A new version of the data to show.
     - parameter animated: Flag unused in this class. See `DifferentiableCollectionManager` instead.
     
     */
    open func update(to: CollectionType, animated: Bool) {
        
        self.collection = to
        collectionView.reloadData()
    }
    
    // MARK: Data Source
    
    /**
     
     `UICollectionViewDataSource` conformance.
     
     - returns: The `numberOfSections()` of `collection`.
     
     */
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collection.numberOfSections()
    }
    
    /**
     
     `UICollectionViewDataSource` conformance.
     
     - returns: The `numberOfItems(in:) collection`.
     
     */
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.numberOfItems(in: section)
    }
    
    /**
     
     `UICollectionViewDataSource` conformance. Subclasses should override this method to provide a custom cell, typically populated using `collection.item(at:)`.
     
     */
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        
        return cell
    }
    
    
    
}
