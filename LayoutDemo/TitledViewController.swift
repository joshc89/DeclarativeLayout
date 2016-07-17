//
//  ViewController.swift
//  LayoutDemo
//
//  Created by Josh Campion on 17/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

import DeclarativeLayout

/**
 
 Simple view controller example adding a fixed layout in `viewDidLoad()` if you have a static layout.
 
 */
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let titleLayout = TitledLayout(title: "Hello, World!", subtitle: "This is a long description that should wrap onto multiple lines on smaller devices. Just centering this layout will lead to text overflowing the edge of the device")
        view.addLayout(titleLayout)
        
        // centered title
        let centerConstraints = titleLayout.boundary.constraintsCenteringOn(view.layoutMarginsGuide, xBuffer: 0, yBuffer: 0)
        view.addConstraints(centerConstraints)
        
        /*
         // top positioned title
         let topConstraint = titleLayout.boundary.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
         let edgeConstraints = titleLayout.boundary.constraintsAligningEdgesTo(view.layoutMarginsGuide)
         view.addConstraints([edgeConstraints[1], edgeConstraints[3], topConstraint])
         */
    }

}

/**
 
 More realistic example which uses dependency injection to create a view controller with programmatic layout, where the layout information is encapsulated inside a `Layout` object.
 
 */
class TitledViewController: UIViewController {

    let titleLayout: TitledLayout
    
    init(title:String?, subtitle:String?) {
        
        titleLayout = TitledLayout(title: title, subtitle: subtitle)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use `init(title:subtitle:)` instead.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.whiteColor()
        view.addLayout(titleLayout)
        
        /*
        // centered title
        let centerConstraints = titleLayout.boundary.constraintsCenteringOn(view.layoutMarginsGuide, xBuffer: 0, yBuffer: 0)
        view.addConstraints(centerConstraints)
        */
        
        
        // top positioned title
        let topConstraint = titleLayout.boundary.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        let edgeConstraints = titleLayout.boundary.constraintsAligningEdgesTo(view.layoutMarginsGuide)
        view.addConstraints([edgeConstraints[1], edgeConstraints[3], topConstraint])
    }

}

