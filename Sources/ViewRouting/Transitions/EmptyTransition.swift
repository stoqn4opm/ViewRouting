//
//  EmptyTransition.swift
//  
//
//  Created by Stoyan Stoyanov on 05/05/22.
//

#if canImport(UIKit)

import Foundation
import UIKit

// MARK: - Definition

public final class EmptyTransition {
    public var isAnimated: Bool
    public let invokeCompletion: Bool
    
    public init(isAnimated: Bool = true, invokeCompletion: Bool = false) {
        self.isAnimated = isAnimated
        self.invokeCompletion = invokeCompletion
    }
}

// MARK: - Transition Conformance

extension EmptyTransition: Transition {

    public func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        guard invokeCompletion else { return }
        completion?()
    }
    
    public func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        guard invokeCompletion else { return }
        completion?()
    }
}

#endif
