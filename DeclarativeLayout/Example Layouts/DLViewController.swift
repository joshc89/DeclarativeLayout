//
//  DLViewController.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 25/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

/// Convenience view controller subclass for creating a view controller with a `Layout`.
public class DLViewController: UIViewController {

    /// The UI for this view controller.
    public let layout:Layout
    
    /// Internal variable set on initialisation for the inset of `layout` from the view controller's view's `layoutMargins`.
    let insets: UIEdgeInsets
    
    /// Internal variable set on initialisation for the backgroundColor of the view controller's view. This is needed to store the color between `init` and `viewDidLoad(_:)` as (UIViewController.init(nibName:bundle:)` initialises with a transparent view if `nil` is passed for both parameters.
    let backgroundColor: UIColor
    
    /// Internal variable stored between `init` and `viewDidLoad(_:)`.
    let toMargins: Bool
    
    /**
     
     Default initialiser.
     
     - parameter layout: The UI for this view controller. Set as `layout`.
     - parameter insets: The inset of `layout` from the view controller's view's edge or `layoutMargins` depending on `toMargins`. Default value is zero.
     - parameter toMargins: Flag for whether `insets` should be taken from the edge of the view or the `layoutMargins`.
     - parameter backgroundColor. The background color for the view. Default value is white.
    */
    public init(layout: Layout, insets: UIEdgeInsets = UIEdgeInsetsZero, toMargins:Bool = true, backgroundColor: UIColor = UIColor.whiteColor()) {
        
        self.layout = layout
        self.insets = insets
        self.toMargins = toMargins
        self.backgroundColor = backgroundColor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use 'init(layout:insets:)' instead.")
    }
    
    /// Adds `layout` constraining it to the `layoutMarginsGuide` based on the insets given in `init(layout:marginInsets:backgroundColor:)`. 
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the view
        view.backgroundColor = backgroundColor
        
        // create & constrain the hierarchy
        view.addLayout(layout)
        let boundingLayout: Layout = toMargins ? view.layoutMarginsGuide : view
        let insetConstraints = layout.boundary.constraintsAligningEdgesTo(boundingLayout.boundary, withInsets: insets)
        NSLayoutConstraint.activateConstraints(insetConstraints)
    }
    
}