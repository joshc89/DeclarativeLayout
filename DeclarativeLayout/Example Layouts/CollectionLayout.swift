//
//  CollectionLayout.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 19/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Simple layout that includes a `UICollectionView` populated by a `CollectionManager`.
public class CollectionLayout<CollectionType: CollectionModel>: Layout {
    
    // MARK: Properties
    
    /// Convenience accessor for the `collectionView` of `manager`.
    public var collectionView: UICollectionView {
        return manager.collectionView
    }
    
    /// The object that is managing this table.
    public let manager: CollectionManager<CollectionType>
    
    // MARK: Initialisers
    
    /// Declarative initialiser of a table and its data source.
    public init(dataSource: CollectionManager<CollectionType>) {
        self.manager = dataSource
    }
    
    // MARK: Layout Conformance
    
    /**
     
     `Layout` conformance.
     
     - returns: `collectionView`.
     
     */
    public var boundary: AnchoredObject {
        return collectionView
    }
    
    /**
     
     `Layout` conformance.
     
     - returns: An array of just `collectionView`.
     
     */
    public var elements: [Layout] {
        return [collectionView]
    }
}
