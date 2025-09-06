//
//  PushTransition.swift
//  
//
//  Created by Stoyan Stoyanov on 05/05/22.
//

#if canImport(UIKit)

import Foundation
import UIKit

// MARK: - Definition

public final class PushTransition: NSObject {
    public var isAnimated: Bool
    weak var explicitNavigationController: UINavigationController?

    private weak var from: UIViewController?
    private var openCompletionHandler: (() -> Void)?
    private var closeCompletionHandler: (() -> Void)?
    
    public init(from navigationController: UINavigationController? = nil, isAnimated: Bool = true) {
        self.isAnimated = isAnimated
        super.init()
        self.explicitNavigationController = navigationController
    }
    
    private var navigationController: UINavigationController? {
        self.explicitNavigationController ??
        from as? UINavigationController ??
        from?.navigationController
    }
}

// MARK: - Transition Conformance

extension PushTransition: Transition {
    
    public func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        self.from = from
        openCompletionHandler = completion
        navigationController?.delegate = self
        navigationController?.pushViewController(viewController, animated: isAnimated)
    }

    public func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        closeCompletionHandler = completion
        navigationController?.popViewController(animated: isAnimated)
    }
}

// MARK: - UINavigationControllerDelegate

extension PushTransition: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let transitionCoordinator = navigationController.transitionCoordinator,
            let fromVC = transitionCoordinator.viewController(forKey: .from),
            let toVC = transitionCoordinator.viewController(forKey: .to) else { return }

        if fromVC == from {
            openCompletionHandler?()
            openCompletionHandler = nil
        } else if toVC == from {
            closeCompletionHandler?()
            closeCompletionHandler = nil
        }
    }
}

#endif
