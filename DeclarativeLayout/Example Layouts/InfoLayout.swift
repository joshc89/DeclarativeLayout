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
open class InfoLayout: Layout {
    
    static func defaultTextLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.setContentCompressionResistancePriority(755, for: .vertical)
        return label
    }
    
    static func defaultImageView() -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }
    
    /// Label for showing the info message. Default font is `UIFontTextStyleBody`.
    public let textLabel: UILabel
    
    /// View for showing the image.
    public let imageView: UIImageView
    
    /// Vertical stack holding `imageView` and `textLabel` with 8 spacing.
    public let infoStack: UIStackView
    
    /// Button laid out behind `infoStack` to add action handling.
    public let button = UIButton(type: .custom)
    
    /// Applies a tint to the `imageView` and `textLabel`
    public var color: UIColor {
        didSet {
            apply(color: color)
        }
    }
    
    private func apply(color: UIColor) {
        textLabel.textColor = color
        imageView.tintColor = color
    }
    
    public init(textLabel: UILabel,
                imageView: UIImageView,
                maxWidth: CGFloat? = 280,
                color: UIColor = UIColor.black.withAlphaComponent(0.5)) {
        
        self.textLabel = textLabel
        self.imageView = imageView
        
        self.color = color
        
        infoStack = UIStackView(arrangedSubviews: [imageView, textLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4.0
        infoStack.alignment = .center
        infoStack.distribution = .equalSpacing
        
        UIView.useInAutoLayout([button, imageView, textLabel, infoStack])
        
        [imageView, textLabel, infoStack].forEach { $0.isUserInteractionEnabled = false }
        
        if let width = maxWidth {
            button.widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        }
        
        boundary = button
        elements = [button, infoStack]
        constraints = infoStack.constraintsAligningEdges(to: self.button)
        
        apply(color: color)
    }
    
    /**
     
     Convenience initialiser.
     
     - parameter message: The text for `textLabel`.
     - parameter image: The image for `imageView`.
     - paramter width: If set, a width constraint is added to prevent this layout from being larger than this value. Default value is 280.
     - parameter color: The `color` to apply to this info layout. Default value is 50% opacity black.
     
    */
    public convenience init(message:String?,
                image:UIImage?,
                maxWidth:CGFloat? = 280.0,
                color: UIColor = UIColor.black.withAlphaComponent(0.5)) {
        
        self.init(textLabel: InfoLayout.defaultTextLabel(),
                  imageView: InfoLayout.defaultImageView(),
                  maxWidth: maxWidth,
                  color: color)
        
        textLabel.text = message
        imageView.image = image
    }
    
    // MARK: Layout Conformance
    
    /// The `button` and `infoStack` define the hierarchy for this layout.
    public let elements: [Layout]
    
    /// The button is aligned to the edges of `textStack` so defines the edges of this hierarchy.
    public let boundary: AnchoredObject
    
    /// - returns: Constraints aligning the `button` and `infoStack` edges.
    public let constraints: [NSLayoutConstraint]
}
