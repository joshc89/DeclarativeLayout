//
//  AsyncModelsViewController.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 16/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

import DeclarativeLayout

/// Demo class for using the TableManager as a data source on an new table view powered by an async request.
class AsyncModelsViewController: DLViewController {
    
    // - note: In a live app this could be specified using a protocol and passed in using injection.
    let loader: CarLoader
    
    /// The main layout displaying the content of this view.
    let tableLayout: TableLayout<ArrayCollection<CarManufacturer> >
    
    
    
    /// Used to show a spinner during loading
    let spinner: UIActivityIndicatorView = {
       
        let s = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        s.color = .darkGray
        s.hidesWhenStopped = true
        return s
    }()
    
    /// Layout to show an error message if loading occurs.
    let errorLayout = InfoLayout(message: "", image: #imageLiteral(resourceName: "ic_warning"))
    
    /// Initialise this view controller with an object to load the data.
    init(loader: CarLoader = CarLoader()) {
        
        self.loader = loader
        
        let manager = CarTableManager(tableView: UITableView(),
                                      collection: ArrayCollection(sections: []))
        
        let table = TableLayout(dataSource: manager)
        table.tableView.backgroundColor = .clear
        self.tableLayout = table
        
        let totalLayout = OverlayLayout(children: [table, CenterLayout(child:errorLayout), CenterLayout(child: spinner)])
        
        super.init(layout: totalLayout, backgroundColor: UIColor(white: 0.95, alpha: 1.0))
        
        errorLayout.button.addTarget(self, action: #selector(AsyncModelsViewController.errorTapped) , for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Kicks off an initial load of the data.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    /// Configures the layouts for loading and makes the async request showing either the table or error layouts depending on the success of the load.
    func loadData() {
        
        errorLayout.hide(true)
        tableLayout.hide(true)
        
        spinner.startAnimating()
        
        loader.loadDataInBackground(delay: 1) { [weak self] (result) in
            
            self?.spinner.stopAnimating()
            
            switch result {
            case .success(let found):
                self?.tableLayout.hide(false)
                self?.tableLayout.manager.update(to: ArrayCollection(sections: found), animated: false)
                self?.errorLayout.hide(true)
            case .failure(let error):
                self?.tableLayout.hide(true)
                self?.errorLayout.hide(false)
                self?.errorLayout.textLabel.text = error.localizedDescription
            }
        }
    }
    
    func errorTapped(_ sender: UIButton) {
        loadData()
    }
}
