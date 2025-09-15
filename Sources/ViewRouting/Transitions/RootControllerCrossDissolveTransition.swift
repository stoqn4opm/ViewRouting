//
//  File.swift
//  ViewRouting
//
//  Created by stoyan on 6.09.25.
//

#if canImport(UIKit)

import Foundation
import UIKit

// MARK: - RootControllerCrossDissolveTransition Dependencies

public protocol WindowProvider {
    func window(for: UIViewController) -> UIWindow?
}

public final class PresentedControllerWindowProvider: WindowProvider {
    
    public init() { }
    
    public func window(for viewController: UIViewController) -> UIWindow? {
        viewController.view.window
    }
}

public protocol WindowSceneProvider {
    var connectedScenes: Set<UIScene> { get }
}

extension UIApplication: WindowSceneProvider { }

public final class ActiveSceneFirstWindowProvider: WindowProvider {
    
    private let application: WindowSceneProvider
    
    public init(application: WindowSceneProvider = UIApplication.shared) {
        self.application = application
    }
    
    public func window(for viewController: UIViewController) -> UIWindow? {
        windowScene?.windows.first
    }
    
    private var windowScene: UIWindowScene? {
        application.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
}

// MARK: - Definition

/// Transition that swaps the root view controller of the window,
/// in which the `from` view controller is presented, with the
/// `viewController` that you want to transition to.
public final class RootControllerCrossDissolveTransition {
    public var isAnimated: Bool
    private let animationOptions: UIView.AnimationOptions
    private let animationDuration: TimeInterval
    private let windowProvider: WindowProvider
    
    /// Memory hook, used for closing down the transition.
    /// Weak reference is used, so that the view controller
    /// is not hold in memory, only so that it can be transitioned
    /// back to.
    private weak var fromController: UIViewController?
    
    public init(isAnimated: Bool = true,
                animationDuration: TimeInterval = 0.3,
                animationOptions: UIView.AnimationOptions = [.transitionCrossDissolve],
                windowProvider: WindowProvider = PresentedControllerWindowProvider()) {
        self.isAnimated = isAnimated
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
        self.windowProvider = windowProvider
    }
}

// MARK: - Transition Conformance

extension RootControllerCrossDissolveTransition: Transition {
    
    public func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        guard let window = windowProvider.window(for: viewController) else {
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
