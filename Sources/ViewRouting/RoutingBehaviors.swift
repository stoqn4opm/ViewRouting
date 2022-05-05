//
//  RoutingBehaviors.swift
//  
//
//  Created by Stoyan Stoyanov on 05/05/22.
//

#if canImport(UIKit)

import Foundation
import UIKit

// MARK: - Routing Related Behaviors

/*
 
 Assuming we want to 'route' users to other screens,
 we'd need a couple of protocols to represent those behaviors.
 
 A route should be able to be 'shown', 'closed' and 'dismissed'.
 The difference between the 'close' and 'dismiss' behavior is that 'close' will apply
 the same `Transition` received during the routing, while 'dismiss' will
 forcibly dismiss the screen.
 
 */

/// Closes the Router's root view controller using the transition used to show it.
public protocol Closable: AnyObject {
    /// Closes the Router's root view controller using the transition used to show it.
    func close()

    /// Closes the Router's root view controller using the transition used to show it.
    func close(completion: (() -> Void)?)
}

/// Dismisses the Router's root view controller ignoring the transition used to show it.
public protocol Dismissable: AnyObject {
    /// Dismisses the Router's root view controller ignoring the transition used to show it.
    func dismiss()

    /// Dismisses the Router's root view controller ignoring the transition used to show it.
    func dismiss(completion: (() -> Void)?)
}

#endif
