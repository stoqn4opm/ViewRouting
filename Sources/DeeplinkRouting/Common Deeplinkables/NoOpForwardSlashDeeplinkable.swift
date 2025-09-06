//
//  File.swift
//  ViewRouting
//
//  Created by stoyan on 6.09.25.
//

import Foundation

// MARK: - Definition

/// `Deeplinkable` that handles URLs with first path component set as "/"
/// by doing nothing. Exists because the first forward slash after the authority (host)
/// part of the url is treated as the first path component.
///
/// With `NoOpForwardSlashDeeplinkable` we basically have a way to consume it
/// when we traverse the url path and do nothing because of it.
public final class NoOpForwardSlashDeeplinkable: Deeplinkable {
    
    public init() { }
    
    public func canHandle(url: URL) -> Bool {
        url.pathComponents.first == "/"
    }
    
    public func deeplink(to url: URL) async throws {
        guard canHandle(url: url) == false else { return }
        throw NSError(domain: "[NoOpForwardSlashDeeplinkable] unsupported url: \(url.absoluteString)", code: 1)
    }
}

