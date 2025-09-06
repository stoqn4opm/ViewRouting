//
//  ViewRouting.swift
//  ViewRouting
//
//  Created by Stoyan Stoyanov on 05/05/22.
//


#if canImport(UIKit)

import Foundation
import UIKit

// MARK: - Router Type

/// Route to a view controller using the transition provided.
public protocol Routable: AnyObject {
    /// Route to a view controller using the transition provided.
    func route(to viewController: UIViewController, as transition: Transition)

    /// Route to  a view controller using the transition provided.
    func route(to viewController: UIViewController, as transition: Transition, completion: (() -> Void)?)
}

public protocol Router: Routable {
    /// The root view controller of this router.
    var root: UIViewController? { get set }
}

// MARK: - Router Type Utilities

/// Protocol providing default `decoratee` forwarding behaviour for router decorators.
public protocol RouterDecorator: Router {
    var decoratee: Router { get }
}

public extension RouterDecorator {
    var root: UIViewController? {
        get { decoratee.root }
        set { decoratee.root = newValue }
    }
    
    func route(to viewController: UIViewController, as transition: Transition) {
        decoratee.route(to: viewController, as: transition)
    }
    
    func route(to viewController: UIViewController, as transition: Transition, completion: (() -> Void)?) {
        decoratee.route(to: viewController, as: transition, completion: completion)
    }
}

#endif
