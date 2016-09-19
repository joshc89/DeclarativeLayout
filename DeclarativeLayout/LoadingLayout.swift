//
//  File.swift
//  DeclarativeLayout
//
//  Created by Joshua Campion on 16/09/2016.
//  Copyright © 2016 Josh Campion. All rights reserved.
//

import Foundation

enum LoadingState<Value> {
    case unloaded
    case loading
    case loaded(Value)
    case errored(Error)
}

let TotalLayout: Layout = {

    let unloaded = InfoLayout(message: "Tap to load", image: #imageLiteral(resourceName: "swift"))
    let error = InfoLayout(message: "broken", image: #imageLiteral(resourceName: "ic_warning"))
    let loading = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let loaded = UIView() // table / collection / detail view
    loading.color = .darkGray
    
    let overlays = OverlayLayout(children: [
        loaded,
        CenterLayout(child: unloaded),
        CenterLayout(child: loading),
        CenterLayout(child: error)
        ])
    
    let view = UIView()
    view.add(layout: overlays)
    NSLayoutConstraint.activate(overlays.boundary.constraintsAligningEdges(to: view))
    
    // This type of syntax looks nice but violates the idea that a Layout is self contained
//    view.add(layout: CenteredLayout(child: unloaded, on: view.layoutMarginsGuide))
//    view.add(layout: CenteredLayout(child: loading, on: view.layoutMarginsGuide))
//    view.add(layout: OverlayedLayout(child: loaded, on: view))
//    view.add(layout: CenteredLayout(child: error, on: view.layoutMarginsGuide))
    
    view.add(layout: unloaded)
    view.add(layout: loading)
    view.add(layout: loaded)
    view.add(layout: error)
    
    let all:[[NSLayoutConstraint]] = [
        unloaded.boundary.constraintsCentering(on: view.layoutMarginsGuide),
        loading.boundary.constraintsCentering(on: view.layoutMarginsGuide),
        loaded.boundary.constraintsAligningEdges(to: view),
        error.boundary.constraintsCentering(on: view.layoutMarginsGuide)
    ]
    
    NSLayoutConstraint.activate(all.reduce([], +))
    
    return view
    
}()

// The below could be useful but offer little over using constraintsCentering(on:), constraintsAligningEdges(to:)

