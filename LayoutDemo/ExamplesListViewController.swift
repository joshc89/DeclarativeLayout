//
//  ExamplesListViewController.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 17/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

import DeclarativeLayout

class ExampleListViewController: UITableViewController {
    
    let viewControllerInfo: [(title:String, viewController: UIViewController)]
    
    required init?(coder aDecoder: NSCoder) {
        
        let titleVC = TitledViewController(title: "Hello, World!", subtitle: "This is a long description that should wrap onto multiple lines on smaller devices. Just centering this layout will lead to text overflowing the edge of the device")
        
        let infoVC = InfoViewController(message: "Tap to launch 'Live Help' with one of our advisors.", image: UIImage(named: "ic_live_help_48pt")!)
        
        let errorVC = ErrorViewController()
        
        // create the article from html
        let url = Bundle.main.url(forResource: "Article", withExtension: "html")!
        let body = (try? NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue) as String?) ?? ""
        let article = Article(image: UIImage(named: "swift"),
                              title: "Swift 3 and Xcode 8",
                              date: Date(),
                              bodyHTML: body ?? "")
        
        let articleVC = ArticleViewController(article: article)
        
        // create the table info
        viewControllerInfo = [
            ("Titled Layout", titleVC),
            ("Info Layout", infoVC),
            ("Error Layout", errorVC),
            ("Parallax Scroll Layout", ExampleListViewController.createParallaxScrollExample()),
            ("Article Layout", articleVC)
        ]
        
        super.init(coder: aDecoder)
    }
    
    static func createParallaxScrollExample() -> DLViewController {
        
        let back = UIView()
        back.backgroundColor = UIColor.red.withAlphaComponent(0.75)
        back.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        let front = UIView()
        front.backgroundColor = UIColor.blue.withAlphaComponent(0.75)
        front.heightAnchor.constraint(equalToConstant: 640).isActive = true
        
        let para = ParallaxScrollLayout(background: back, foreground: front)
        
        return DLViewController(layout: para)
    }
    
    // MARK: UITableView Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllerInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "VCCell")
        
        cell.textLabel?.text = viewControllerInfo[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toShow = viewControllerInfo[indexPath.row].viewController
        self.show(toShow, sender: self)
    }
}
