//
//  FadeAnimatedTransitioning.swift
//  
//
//  Created by Stoyan Stoyanov on 05/05/22.
//

#if canImport(UIKit)

import Foundation
import UIKit

public final class FadeAnimatedTransitioning: NSObject, AnimatedTransitioning {
    public var isPresenting: Bool = true

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.35
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            present(using: transitionContext)
        } else {
            dismiss(using: transitionContext)
        }
    }

    private func present(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }

        let containerView = transitionContext.containerView
        toView.alpha = 0.0
        containerView.addSubview(toView)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func dismiss(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.alpha = 0.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

#endif
