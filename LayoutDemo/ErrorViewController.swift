//
//  ErrorLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 17/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

import DeclarativeLayout

/**
 
 Example demostrating how a composable `Layout` can be made up of a view including other child `Layout`s.
 
     ErrorLayout.child = TitledStack:Layout + UITextField:UIView
 */
class ErrorViewController: UIViewController, UITextFieldDelegate {
    
    let emailTextField = UITextField()
    
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    
    /// The layout that contains the content and the error. This is a `var` as the `error` is changed as the user enters text.
    var errorLayout: ErrorLayout
    
    init() {
        
        // create the layout
        let title = TitledLayout(title: "Email Address", subtitle: "Please enter an email address so we can keep in touch:")
        
        let titleStack = UIStackView(arrangedLayouts: [title, emailTextField])
        titleStack.axis = .Vertical
        titleStack.spacing = 8.0
        
        errorLayout = ErrorLayout(child: titleStack)
        errorLayout.label.textColor = UIColor.redColor()
        errorLayout.iconView.tintColor = UIColor.redColor()
        
        // complete initialisation
        super.init(nibName: nil, bundle: nil)
        
        // configure the textfield
        emailTextField.borderStyle = .RoundedRect
        emailTextField.autocorrectionType = .No
        emailTextField.autocapitalizationType = .None
        emailTextField.keyboardType = .EmailAddress
        emailTextField.returnKeyType = .Done
        emailTextField.delegate = self
        emailTextField.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        view.add(layout: errorLayout)
        
        // set up the layout constraints
        let topConstraint = errorLayout.boundary.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        let edgeConstraints = errorLayout.boundary.constraintsAligningEdges(to: view.layoutMarginsGuide)
        view.addConstraints([edgeConstraints[1], edgeConstraints[3], topConstraint])
    }
    
    
    // MARK: UITextFieldDelegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if predicate.evaluateWithObject(textField.text) {
            errorLayout.error = nil
        } else {
            errorLayout.error = ErrorLayout.Error(message: "Invalid email address entered.", icon: UIImage(named: "ic_warning"))
        }
    }
}
