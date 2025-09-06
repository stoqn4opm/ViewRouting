//
//  File.swift
//  ViewRouting
//
//  Created by stoyan on 6.09.25.
//

import Foundation

/// `Deeplinkable` decorator that can execute optional closures before/after invoking decoratee's `deeplink(to:)`
public final class ClosureDeeplinkable: Deeplinkable {
    
    public let before: @MainActor (_ url: URL) async throws -> Void
    public let decoratee: Deeplinkable
    public let after: @MainActor (_ url: URL) async throws -> Void
    
    public init(before: @escaping @MainActor (_: URL) async throws -> Void = { _ in },
         decoratee: Deeplinkable,
         after: @escaping @MainActor (_: URL) async throws -> Void = { _ in }) {
        self.before = before
        self.decoratee = decoratee
        self.after = after
    }
    
    public func canHandle(url: URL) -> Bool {
        decoratee.canHandle(url: url)
    }
    
    public func deeplink(to url: URL) async throws {
        try await before(url)
        try await decoratee.deeplink(to: url)
        try await after(url)
    }
}
