//
//  File.swift
//  ViewRouting
//
//  Created by stoyan on 6.09.25.
//

#if canImport(ViewRouting)

import Foundation
import ViewRouting

// MARK: - Definition

/// `Deeplinkable` decorator, that executes an `Executable` after it has
/// passed the invocations to its decoratee.
///
/// Useful for finalising traversal of deeplinable trees,
/// when their navigation operations are composed and its time to be performed
public final class ExecutingDeeplinkable: Deeplinkable {
    
    public let decoratee: Deeplinkable
    public let executable: Executable
    
    public init(decoratee: Deeplinkable, executable: Executable) {
        self.decoratee = decoratee
        self.executable = executable
    }
    
    public func canHandle(url: URL) -> Bool {
        decoratee.canHandle(url: url)
    }
    
    @MainActor public func deeplink(to url: URL) async throws {
        try await decoratee.deeplink(to: url)
        executable.execute()
    }
}

#endif
