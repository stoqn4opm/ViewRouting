//
//  AnimatedTransitioning.swift
//  
//
//  Created by Stoyan Stoyanov on 05/05/22.
//

#if canImport(UIKit)

import Foundation
import UIKit


// MARK: - Animated Transitioning

/// Protocol which exposes a set of methods for implementing
/// the animations for a custom view controller transition.
public protocol AnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    
    /// Use this to keep track of where you are in the transition.
    var isPresenting: Bool { get set }
}

#endif
