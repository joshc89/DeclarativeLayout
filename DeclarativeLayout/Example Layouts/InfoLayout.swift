//
//  InfoLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/**
 
 Layout for showing a typical info view used for showing un-intrusive errors or empty state messages accompanied with an icon. These are stacked vertically with a button behind to allow actions to be associated with this info, such as retry from the error.
 
 *include image*
 
 */
public struct InfoLayout: Layout {
    
    /// Label for showing the info message. Default font is `UIFontTextStyleBody`.
    public let textLabel = UILabel()
    
    /// View for showing the image.
    public let imageView = UIImageView()
    
    /// Vertical stack holding `imageView` and `textLabel` with 8 spacing.
    public let infoStack: UIStackView
    
    /// Button laid out behind `infoStack` to add action handling.
    public let button = UIButton(type: .Custom)
    
    /**
     
     Default initialiser.
     
     - parameter message: The text for `textLabel`.
     - parameter image: The image for `imageView`.
     - paramter width: If set, a width constraint is added to prevent this layout from being larger than this value. Default value is 280.
     
    */
    public init(message:String?, image:UIImage?, maxWidth:CGFloat? = 280.0) {
                
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        textLabel.setContentCompressionResistancePriority(755, forAxis: .Vertical)
        textLabel.text = message
        
        imageView.image = image
        
        infoStack = UIStackView(arrangedSubviews: [imageView, textLabel])
        infoStack.axis = .Vertical
        infoStack.spacing = 8.0
        infoStack.alignment = .Center
        infoStack.distribution = .EqualSpacing
        
        UIView.useInAutoLayout([button, imageView, textLabel, infoStack])
        
        if let width = maxWidth {
            button.widthAnchor.constraintLessThanOrEqualToConstant(width).active = true
        }
        
        boundary = button
        elements = [button, infoStack]
    }
    
    // MARK: Layout Conformance
    
    /// The `button` and `infoStack` define the hierarchy for this layout.
    public let elements: [Layout]
    
    /// The button is aligned to the edges of `textStack` so defines the edges of this hierarchy.
    public let boundary: AnchoredObject
    
    /// - returns: Constraints aligning the `button` and `infoStack` edges.
    public func generateConstraints() -> [NSLayoutConstraint] {
        
        return infoStack.constraintsAligningEdgesTo(button)
    }
}
