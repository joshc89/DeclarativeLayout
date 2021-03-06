//
//  ErrorLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/**
 
 A layout that vertically stacks a child `Layout` with an error caption label and image.
 
 *include image*
 
 */
open class ErrorLayout: BaseLayout {
    
    static func defaultLabel() -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        return label
    }
    
    static func defaultImageView() -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }
    
    /// Internal struct used to encapsulate the objects needed to show an error.
    public struct ErrorObject {
        
        /// The text of the error
        public let message: String
        
        /// The associated image of the error.
        public let icon: UIImage?
        
        /// Default initialiser.
        public init(message: String, icon: UIImage?) {
            self.message = message
            self.icon = icon
        }
    }
    
    /// Optional `Error` that configures the UI. When this is `nil`, `errorStack` is hidden.
    open var error: ErrorObject? {
        didSet {
            label.text = error?.message
            label.isHidden = error?.message == nil
            
            iconView.image = error?.icon
            iconView.isHidden = error?.icon == nil
            iconWidthConstraint.constant = error?.icon?.size.width ?? 0
            
            errorStack.isHidden = error == nil
        }
    }
    
    /// The label showing the `message` of `error`. Default font is `UIFontTextStyleCaption1`.
    public let label: UILabel
    
    /// The image view showing the `image` of `error`. This is constrained to be the width of the image and top aligned with the label.
    public let iconView: UIImageView
    
    /// Internal variable for the width of `imageView` with priority 900, updated when `error` is set.
    let iconWidthConstraint:NSLayoutConstraint
    
    /// The stack containing `label` and `iconView`
    public let errorStack: UIStackView
    
    /// The stack containing `child` and `errorStack`. This defines the `boundary` and `elements` of this `Layout`.
    public let stack: UIStackView
    
    /// The sub layout that this layout is adding an error to.
    public let child: Layout
    
    /**
     
     Default initialiser. Sets the `child` property that is supplemented with an error label and icon.
     
    */
    public init(child: Layout,
                label:UILabel = ErrorLayout.defaultLabel(),
                iconView: UIImageView = ErrorLayout.defaultImageView()) {
        
        self.child = child
        self.label = label
        self.iconView = iconView
        
        errorStack = UIStackView(arrangedSubviews: [iconView, label])
        errorStack.spacing = 8.0
        
        iconWidthConstraint = iconView.widthAnchor.constraint(equalToConstant: 0)
        iconWidthConstraint.priority = 900
        iconWidthConstraint.isActive = true
        
        stack = UIStackView(arrangedLayouts: [child, errorStack])
        stack.axis = .vertical
        stack.spacing = 8.0
        
        super.init(view: stack)
    }
}
