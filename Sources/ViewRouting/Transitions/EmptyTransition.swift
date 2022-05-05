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
    
    public init(isAnimated: Bool = true) {
        self.isAnimated = isAnimated
    }
}

// MARK: - Transition Conformance 

extension EmptyTransition: Transition {

    public func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {}
    public func close(_ viewController: UIViewController, completion: (() -> Void)?) {}
}

#endif
