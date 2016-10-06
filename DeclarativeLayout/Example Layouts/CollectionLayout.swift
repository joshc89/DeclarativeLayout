//
//  CollectionLayout.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 19/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/// Simple layout that includes a `UICollectionView` populated by a `CollectionManager`.
open class CollectionLayout<CollectionType: CollectionModel>: BaseLayout {
    
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
        
        super.init(view: dataSource.collectionView)
    }
}
