//
//  ArticleViewController.swift
//  DeclarativeLayout
//
//  Created by Josh Campion on 17/07/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import UIKit
import DeclarativeLayout

// Content from recent Swift Blog Post: https://developer.apple.com/swift/blog/?id=36

struct Article {
    
    let image: UIImage?
    let title: String
    let date: NSDate
    let bodyHTML: String
}

class ArticleViewController: UIViewController {
    
    let parallaxScrollLayout: ParallaxScrollLayout
    
    init(article:Article) {
        
        // create the foreground content for the scroll layout
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .MediumStyle
        
        let dateString = dateFormatter.stringFromDate(article.date)
        
        let titleLayout = TitledLayout(title: article.title, subtitle: dateString)
        
        let articleData = article.bodyHTML.dataUsingEncoding(NSUTF8StringEncoding)
        let articleBody = try? NSAttributedString(data: articleData ?? NSData(),
                                                  options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding],
                                                  documentAttributes: nil)
        
        let articleLabel = UILabel()
        articleLabel.numberOfLines = 0
        articleLabel.attributedText = articleBody
        
        let articleContent = UIStackView(arrangedLayouts: [titleLayout, articleLabel])
        articleContent.axis = .Vertical
        articleContent.spacing = 16.0

        let maxWidth = MaxWidthLayout(child: articleContent, maxWidth: 667)
        
        // give the scroll content a white background
        let scrollContentView = UIView()
        scrollContentView.backgroundColor = UIColor.whiteColor()
        scrollContentView.addLayout(maxWidth)
        let contentConstraints = maxWidth.boundary.constraintsAligningEdgesTo(scrollContentView.layoutMarginsGuide, withInsets: UIEdgeInsetsMake(16, 8, 16, 8))
        NSLayoutConstraint.activateConstraints(contentConstraints)
        
        // create the background content for the scroll layout
        let background = UIImageView(image: article.image)
        background.contentMode = .ScaleAspectFit
        
        // create the layout
        parallaxScrollLayout = ParallaxScrollLayout(backgroundLayout: background, foregroundLayout: scrollContentView)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        view.addLayout(parallaxScrollLayout)
        
        let edgeConstraints = parallaxScrollLayout.boundary.constraintsAligningEdgesTo(view)
        view.addConstraints(edgeConstraints)
        
        // ensure hero image isn't too large
        parallaxScrollLayout.backgroundLayout.boundary.heightAnchor.constraintLessThanOrEqualToAnchor(view.heightAnchor, multiplier: 0.5).active = true
    }
}
