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



class ArticleViewController: DLViewController {
    
    init(article:Article) {
        
        // create the foreground content for the scroll layout
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .MediumStyle
        
        let dateString = dateFormatter.stringFromDate(article.date)
        
        // create a text view containing the NSAttributedString representing the html
        let articleData = article.bodyHTML.dataUsingEncoding(NSUTF8StringEncoding)
        let articleBody = try? NSAttributedString(data: articleData ?? NSData(),
                                                  options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding],
                                                  documentAttributes: nil)
        
        
        let articleView = UITextView()
        articleView.attributedText = articleBody
        articleView.scrollEnabled = false
        articleView.editable = false
        articleView.selectable = true
        
        // create the background content for the scroll layout
        let background = UIImageView(image: article.image)
        background.contentMode = .ScaleAspectFit
        
        let articleLayout = DetailPageLayout(title: article.title,
                                             subtitle: dateString,
                                             backgroundLayout: background,
                                             contentLayout: articleView)
        
        super.init(layout: articleLayout, toMargins: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
