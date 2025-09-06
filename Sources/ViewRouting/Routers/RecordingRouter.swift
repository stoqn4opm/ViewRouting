//
//  File.swift
//  ViewRouting
//
//  Created by stoyan on 6.09.25.
//


#if canImport(UIKit)

import Foundation
import UIKit

// MARK: - Route Record Handler

/// A type that collects and executes route records.
private typealias RouteRecordHandler = RouteRecordCollector & Executable

// MARK: - Route Collector Definition

private protocol RouteRecordCollector {
    
    /// Should provide all collected route records up to the moment of calling.
    var records: [RouteRecord] { get }
}

// MARK: - Executable Definition

/// Used for indicating objects that can execute a specific action.
/// For example for the `RouteRecord`s to perform their routing, or
/// for the `RecordingRouter`s to perform their routing steps.
public protocol Executable {
    
    /// Used for executing actions of this executable.
    func execute()
}

// MARK: - Route Record Model

/// Model used for containing information about collected routes by `RouteRecordCollector`s.
private struct RouteRecord: Executable {
    
    /// The place to where the route transition will end.
    let destination: UIViewController
    
    /// The place from where the route transition will start.
    /// In `DefaultRouter`'s ancestors, that is usually the `root` controller of the router.
    let from: UIViewController
    let transition: Transition
    let completion: (() -> Void)?
    
    init(destination: UIViewController, from: UIViewController, transition: Transition, completion: (() -> Void)? = nil) {
        self.destination = destination
        self.from = from
        self.transition = transition
        self.completion = completion
    }
    
    public func execute() {
        transition.open(destination, from: from, completion: completion)
    }
}

// MARK: - Serial Tasks

/// Actor that executes async tasks one after the other.
/// see https://stackoverflow.com/questions/70540541/swift-5-5-concurrency-how-to-serialize-async-tasks-to-replace-an-operationqueue
///
/// Make an instance of it and start adding tasks with the `add`
/// function to execute then one after the other in order.
private actor SerialTasks<Success> {
    private var previousTask: Task<Success, Error>?

    func add(block: @Sendable @escaping () async throws -> Success) async throws -> Success {
        let task = Task { [previousTask] in
            _ = await previousTask?.result
            return try await block()
        }
        previousTask = task
        return try await task.value
    }
}

// MARK: - Route Collector Implementation

/// Router decorator, that collects all routes coming to it and never passing them
/// to the `decoratee`. The collected routes can be accessed via `RouteRecordCollector` interface.
/// The instance also conforms to `Executable`, with the behavior of executing all recorded routes/transitions
/// at once.
///
/// - Note: Once the `records` are executed, they are reset and the `RecordingRouter` behave just as if it just
/// started recording and has no collected records in it.
///
/// Used in the RoutingExample app during the deeplink flows. Mark a route that you want to be available for deeplinking
/// by making it available to `RecordingRouter` via:
///
/// ```swift
/// extension RecordingRouter: <YourRouteNameInYourRouteFile> { }
/// ```
open class RecordingRouter: RouterDecorator, RouteRecordHandler {
    
    public let decoratee: Router
    
    public init(decoratee: Router) {
        self.decoratee = decoratee
    }
    
    fileprivate var records: [RouteRecord] = []
    
    /// Executes commands in order of adding, one by one.
    private let taskSerializer = SerialTasks<Void>()
    
    public func route(to viewController: UIViewController, as transition: Transition) {
        guard let from = root else { return }
        records.append(.init(destination: viewController, from: from, transition: transition))
    }
    
    public func route(to viewController: UIViewController, as transition: Transition, completion: (() -> Void)?) {
        guard let from = root else { return }
        records.append(.init(destination: viewController, from: from, transition: transition, completion: completion))
    }
    
    public func execute() {
        Task {
            for record in records {
                try await taskSerializer.add { @MainActor in
                    record.execute()
                }
            }
            records = []
        }
    }
}


#endif
