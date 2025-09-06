//
//  ViewRouting.swift
//  RoutingExample
//
//  Created by stoyan on 6.09.25.
//

import Foundation
import ViewRouting
import DeeplinkRouting

/// This file contains type alias declarations, to provide types/definitions local in RoutingExample, to which the rest of the code in RoutingExample target to couple to.
/// This is done with the aim to have only this file import ViewRouting and DeeplinkRouting inside RoutingExample, so the the coupling to those dependencies is as loose as possible.
/// Loose coupling to the definitions responsible for routing and navigation in RoutingExample, allows for the routing/navigating mechanism to be changed easily by swapping these type aliases to something else, implemented differently.

// MARK: - ViewRouting Definitions

typealias Router = ViewRouting.Router
typealias Executable = ViewRouting.Executable
typealias RecordingRouter = ViewRouting.RecordingRouter
typealias DefaultRouter = ViewRouting.DefaultRouter
typealias Transition = ViewRouting.Transition
typealias EmptyTransition = ViewRouting.EmptyTransition
typealias PushTransition = ViewRouting.PushTransition
typealias ModalTransition = ViewRouting.ModalTransition
typealias Routable = ViewRouting.Routable
typealias RootControllerCrossDissolveTransition = ViewRouting.RootControllerCrossDissolveTransition


// MARK: - DeeplinkingRouting Definitions

typealias Deeplinkable = DeeplinkRouting.Deeplinkable
typealias ExecutingDeeplinkable = DeeplinkRouting.ExecutingDeeplinkable
typealias DeeplinkableComposite = DeeplinkRouting.DeeplinkableComposite
typealias HTTPSDeeplinkable = DeeplinkRouting.HTTPSDeeplinkable
typealias DeeplinkableTree = DeeplinkRouting.DeeplinkableTree
typealias ClosureDeeplinkable = DeeplinkRouting.ClosureDeeplinkable
typealias NoOpForwardSlashDeeplinkable = DeeplinkRouting.NoOpForwardSlashDeeplinkable
