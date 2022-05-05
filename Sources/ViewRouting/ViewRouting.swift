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

#endif
