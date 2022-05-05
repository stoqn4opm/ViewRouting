//
//  Transition.swift
//  
//
//  Created by Stoyan Stoyanov on 05/05/22.
//

#if canImport(UIKit)

import Foundation
import UIKit

/// Represents a way of opening and closing a screen
/// by applying whatever animation the developer provides.
///
/// For example look at the locally provided Modal or Push transitions
/// for default implementation, or `AnimatedTransition` for custom transitions.
/// (have a look at the source-code to see their implementation).
public protocol Transition: AnyObject {
    var isAnimated: Bool { get set }

    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?)
    func close(_ viewController: UIViewController, completion: (() -> Void)?)
}

#endif
