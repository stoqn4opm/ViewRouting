//
//  File.swift
//  ViewRouting
//
//  Created by stoyan on 6.09.25.
//

#if canImport(UIKit)

import Foundation
import UIKit

// MARK: - Definition

/// Transition that swaps the root view controller of the window,
/// in which the `from` view controller is presented, with the
/// `viewController` that you want to transition to.
public final class RootControllerCrossDissolveTransition {
   public var isAnimated: Bool
    var animationOptions: UIView.AnimationOptions
    var animationDuration: TimeInterval
    
    /// Memory hook, used for closing down the transition.
    /// Weak reference is used, so that the view controller
    /// is not hold in memory, only so that it can be transitioned
    /// back to.
    private weak var fromController: UIViewController?
    
    public init(isAnimated: Bool = true, animationDuration: TimeInterval = 0.3, animationOptions: UIView.AnimationOptions = [.transitionCrossDissolve]) {
        self.isAnimated = isAnimated
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
    }
}

// MARK: - Transition Conformance

extension RootControllerCrossDissolveTransition: Transition {

    public func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        guard let window = from.view.window else {
            print("[RootControllerCrossDissolveTransition] transition failed, as `from.view.window` was nil")
            return
        }
        
        let transition = { window.rootViewController = viewController }
        fromController = from
        
        if isAnimated {
            UIView.transition(with: window, duration: animationDuration, options: animationOptions, animations: transition)
        } else {
            transition()
        }
    }
    public func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        guard let initialController = fromController else { return }
        open(initialController, from: viewController, completion: completion)
    }
}

#endif
