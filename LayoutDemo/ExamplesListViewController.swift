//
//  ExamplesListViewController.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 17/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

class ExampleListViewController: UITableViewController {
    
    let viewControllerInfo: [(title:String, viewController: UIViewController)]
    
    required init?(coder aDecoder: NSCoder) {
        
        let titleVC = TitledViewController(title: "Hello, World!", subtitle: "This is a long description that should wrap onto multiple lines on smaller devices. Just centering this layout will lead to text overflowing the edge of the device")
        
        let infoVC = InfoViewController(message: "Tap to launch 'Live Help' with one of our advisors.", image: UIImage(named: "ic_live_help_48pt")!)
        
        let errorVC = ErrorViewController()
        
        // create the article from html
        let url = NSBundle.mainBundle().URLForResource("Article", withExtension: "html")!
        let body = (try? NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding) as String?) ?? ""
        let article = Article(image: UIImage(named: "swift"),
                              title: "Swift 3 and Xcode 8",
                              date: NSDate(),
                              bodyHTML: body ?? "")
        
        let articleVC = ArticleViewController(article: article)
        
        // create the table info
        viewControllerInfo = [
            ("Titled Layout", titleVC),
            ("Info Layout", infoVC),
            ("Error Layout", errorVC),
            ("Article Layout", articleVC)
        ]
        
        super.init(coder: aDecoder)
    }
    
    // MARK: UITableView Methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllerInfo.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "VCCell")
        
        cell.textLabel?.text = viewControllerInfo[indexPath.row].title
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
        let toShow = viewControllerInfo[indexPath.row].viewController
        self.showViewController(toShow, sender: self)
    }
}
