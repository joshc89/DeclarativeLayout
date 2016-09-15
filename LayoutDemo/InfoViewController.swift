//
//  InfoViewController.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 17/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

import DeclarativeLayout

/// Simple test view controller showing an info panel. In a real app
class InfoViewController: UIViewController {
    
    let infoLayout: InfoLayout
    
    init(message:String, image: UIImage) {
        
        // create and configure the layout
        infoLayout = InfoLayout(message: message, image: image)
        
        let tint = UIColor.blackColor().colorWithAlphaComponent(0.54)
        infoLayout.textLabel.textColor = tint
        infoLayout.imageView.tintColor = tint
        
        super.init(nibName: nil, bundle: nil)
        
        infoLayout.button.addTarget(self, action: #selector(InfoViewController.launchHelp), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use `init(message:image:)` instead.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        view.add(layout: infoLayout)
        
        let centerConstraints = infoLayout.boundary.constraintsCenteringOn(view)
        view.addConstraints(centerConstraints)
    }
    
    func launchHelp() {
        // do something...
    }
    
}
