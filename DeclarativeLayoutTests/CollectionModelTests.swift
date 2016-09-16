//
//  CollectionModelTests.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 15/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import XCTest

@testable import DeclarativeLayout

class CollectionModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test() {
        
        let strings = [
            ArraySection(title: "Coding", indexTitle: "C", items: [
                "Hello World!",
                "Foo bar",
                "Segmentation Fault 11!",
                ]),
            ArraySection(title: "Apple", indexTitle: "A", items: [
                "something magical",
                "our best ever"
                ])
        ]
        
        let manager = PhraseTableManager(tableView: UITableView(),
                                   collection: ArrayCollection(sections: strings))
        let layout = TableLayout(dataSource: manager)
        let _ = DLViewController(layout: layout)
    }
}

class PhraseTableManager<CollectionType: CollectionModel>: TableManager<CollectionType> where CollectionType.Element == String {
    
    override init(tableView: UITableView, collection: CollectionType) {
        
        super.init(tableView: tableView, collection: collection)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        let phrase = collection.item(at: indexPath)
        // configure with `phrase` object
        cell.textLabel?.text = phrase
        
        return cell
    }
    
}
