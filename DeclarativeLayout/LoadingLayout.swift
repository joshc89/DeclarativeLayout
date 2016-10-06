//
//  File.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 16/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

public enum LoadingState<Value> {
    case unloaded
    case loading(Double)
    case loaded(Value)
    case errored(Error)
}

extension LoadingState where Value: Equatable {
    
    static func ==(s1: LoadingState, s2: LoadingState) -> Bool {
        switch (s1, s2) {
        case (.unloaded, .unloaded):
            return true
        case let (.loading(p1), .loading(p2)):
            return p1 == p2
        case let (.loaded(v1), .loaded(v2)):
            return v1 == v2
        case let (.errored(e1), .errored(e2)):
            return e1.localizedDescription == e2.localizedDescription
        default:
            return false
        }
    }
}

public protocol Populating {
    
    associatedtype Value
    
    func populate(with: Value)
}

public protocol Sizing: Populating {
    
    static func fittingSize(for value: Value?, constrainedTo width: CGFloat) -> CGSize
}

open class PopulatingLayout<Value>: BaseLayout, Populating {
    
    private let populator: (Value) -> ()
    
    public init<Type: Populating & Layout>(layout: Type) where Type.Value == Value {
        
        populator = layout.populate(with:)
        
        super.init(boundary: layout.boundary,
                   elements: layout.elements,
                   constraints: layout.constraints)
    }
    
    public func populate(with: Value) {
        populator(with)
    }
}

open class EmptyLoadingLayout: BaseLayout {
    
    public let unloaded: Layout
    public let loading: Layout
    public let errored: PopulatingLayout<Error>
    
    public let stack: UIStackView
    
    open var state: LoadingState<Void> = .unloaded {
        didSet {
            
            stack.arrangedSubviews.forEach { $0.isHidden = true }
            
            switch state {
            case .unloaded:
                
                stack.arrangedSubviews[0].isHidden = false
                
            case .loading:
                stack.arrangedSubviews[1].isHidden = false
            case .errored(let e):
                errored.populate(with: e)
                stack.arrangedSubviews[2].isHidden = false
            case .loaded:
                break
            }
        }
    }
    
    public init(unloaded: Layout, loading: Layout, errored: PopulatingLayout<Error>) {
        
        self.unloaded = unloaded
        self.loading = loading
        self.errored = errored
        
        stack = UIStackView(arrangedLayouts: [unloaded, loading, errored])
        stack.arrangedSubviews[1...2].forEach { $0.isHidden = true }
        
        super.init(view: stack)
    }
}

/// `Layout` that shows a single child based on a `LoadingState`. This can be subclassed to given a layout with consistent children throughout an app and be used to easily show loading progress across multiple views.
open class LoadingLayout<Value>: BaseLayout {
    
    public let unloaded: Layout
    public let loading: Layout
    public let errored: PopulatingLayout<Error>
    public let loaded: PopulatingLayout<Value>
    
    public let stack: UIStackView
    
    open var state: LoadingState<Value> = .unloaded {
        didSet {
            
            stack.arrangedSubviews.forEach { $0.isHidden = true }
            
            switch state {
            case .unloaded:
                
                stack.arrangedSubviews[0].isHidden = false
                
            case .loading:
                stack.arrangedSubviews[1].isHidden = false
            case .errored(let e):
                errored.populate(with: e)
                stack.arrangedSubviews[2].isHidden = false
            case .loaded(let value):
                loaded.populate(with: value)
                stack.arrangedSubviews[3].isHidden = false
            }
        }
    }
    
    public init(unloaded: Layout, loading: Layout, errored: PopulatingLayout<Error>, loaded: PopulatingLayout<Value>) {
        
        self.unloaded = unloaded
        self.loading = loading
        self.errored = errored
        self.loaded = loaded
        
        stack = UIStackView(arrangedLayouts: [unloaded, loading, errored, loaded])
        stack.arrangedSubviews[1...3].forEach { $0.isHidden = true }
        
        super.init(view: stack)
    }
}
