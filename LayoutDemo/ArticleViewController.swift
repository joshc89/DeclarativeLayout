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
    let date: Date
    let bodyHTML: String
}

class ArticleViewController: DLViewController {
    
    init(article:Article) {
        
        // create the foreground content for the scroll layout
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        
        let dateString = dateFormatter.string(from: article.date)
        
        // create a text view containing the NSAttributedString representing the html
        let articleData = article.bodyHTML.data(using: String.Encoding.utf8)
        
        let articleBody = try? NSAttributedString(data: articleData ?? Data(),
                                                  options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                  documentAttributes: nil)
        
        
        let articleView = UITextView()
        articleView.attributedText = articleBody
        articleView.textContainer.lineFragmentPadding = 0;
        articleView.textContainerInset = UIEdgeInsets.zero
        articleView.isScrollEnabled = false
        articleView.isEditable = false
        articleView.isSelectable = true
        
        // create the background content for the scroll layout
        let background = UIImageView(image: article.image)
        background.contentMode = .scaleAspectFit
        
        let articleLayout = ParallaxScrollLayout(backgroundLayout: background,
                                                 title: article.title,
                                                 subtitle: dateString,
                                                 contentLayout: articleView)
        
        super.init(layout: articleLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
