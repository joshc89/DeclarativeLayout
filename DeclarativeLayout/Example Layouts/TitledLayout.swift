//
//  TitledLayout.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 16/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit

/**
 
 Layout consisting of two vertically stacked labels for a title and subtitle.
 
 *include image*
 
 The title and subtitle label have fonts `UIFontTextStyleHeadline` and `UIFontTextStyleSubheadline` respectively. They are spaced 8.0 apart. This can be configured by accessing the `textStack` property.
 
 */
public class TitledLayout: BaseLayout {
    
    /// The label to show the tile in this layout. Font is set to `UIFontTextStyle.headline`.
    public let titleLabel = UILabel()
    
    /// The label to show the subtitle in this layout. Font is set to `UIFontTextStyle.subheadline`.
    public let subtitleLabel = UILabel()
    
    /// `UIStackView` containing the two labels.
    public let textStack: UIStackView
    
    /**
     
     Default initialiser.
     
     - parameter title: The title for this layout. Set as the text of `titleLabel`. If this is `nil` or empty `titleLabel` is hidden.
     - parameter subtitle: The subtitle for this layout. Set as the text of `subtitleLabel`. If this is `nil` or empty `titleLabel` is hidden.
     
     
    */
    public init(title:String?, subtitle:String?) {
        
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        for l in [titleLabel, subtitleLabel] {
            l.numberOfLines = 0
            l.setContentCompressionResistancePriority(755, for: .vertical)
        }
        
        titleLabel.isHidden = title?.isEmpty ?? true
        subtitleLabel.isHidden = subtitle?.isEmpty ?? true
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        UIView.useInAutoLayout([titleLabel, subtitleLabel])
        textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.spacing = 8.0
        
        super.init(view: textStack)
    }
}
