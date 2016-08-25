# Declarative Layout

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Reusable, composable, declarative constraint based layout in Swift.

## Description

Constraint based variant of the protocol described in [WWDC 2016 Session 419: Protocol and Value Oriented Programming in UIKit Apps](https://developer.apple.com/videos/play/wwdc2016/419/).

A [Layout](https://joshc89.github.io/DeclarativeLayout/Protocols/Layout.html) combines one or more views, layout guides and constraints into a single object, including logic, that can be reused and composed of other `Layout`s. It is a protocol that both `UIView` and `UILayoutGuide` conform to, so these can be used as elements in other more complex layouts.

For example, the `ParallaxScrollLayout` takes a `Layout` for the background and foreground. It handles positioning those relative to each other as the user scrolls, adjusting the offset between the two `Layout`s to give a parallax effect. The positioning of the elements within the background / foreground should be in their respective parent `Layout`s.

Encapsultaing this behaviour in a single object rather than in a view controller makes it easier to reuse and update. It also makes it easier to focus on just the code regarding layout, rather than that code being lost in delegate callbacks on parent view controllers.

More example `Layout`s are given within the framework. Download the repo to check them out.

[UIView.addLayout(_:)](https://joshc89.github.io/DeclarativeLayout/Extensions/UIView.html) has been included as a convenience function that adds the elements of a `Layout`, ensuring they can be used correctly in AutoLayout.

[DLViewController](https://joshc89.github.io/DeclarativeLayout/Classes/DLViewController.html) is a convenience class for creating simple `UIViewController`s with a `Layout` parameter. This makes programmatic layout code simpler, removing some of the boilerplate code for setting up the `Layout` within `UIViewController.view`.

*Note: This library supports iOS 9+ as it requires `UILayoutGuide` and `NSLayoutAnchor`*

## Roadmap

- [x] [Documentation](https://joshc89.github.io/DeclarativeLayout/)
- [] Collection Layouts (in progress on branch `feature/Collections`)
- [] State based Layouts and transitions 
- [] macOS support (`NSView`)
- [] Cocopods support
