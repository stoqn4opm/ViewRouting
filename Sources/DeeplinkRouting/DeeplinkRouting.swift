//
//  File.swift
//  ViewRouting
//
//  Created by stoyan on 6.09.25.
//

#if canImport(UIKit)

import UIKit

// MARK: - Deeplinkable Type

/// Type used for declaring deeplink steps related to deeplink path components.
public protocol Deeplinkable {
    
    /// Quick sync check if URL is supported by this deeplink
    func canHandle(url: URL) -> Bool
    
    /// Provides a custom handling of a given URL.
    /// - Parameter url: The URL to be handled.
    func deeplink(to url: URL) async throws
}

// MARK: - Deeplinkable Type Utilities

/// `Deeplinkable` combining many `Deeplinkable`s into one.
///
/// `DeeplinkableComposite`s `canHandle(url: URL)`is `true` if ANY of its `Deeplinkable`s returns `true`
///
/// `DeeplinkableComposite`s `deeplink(to url: URL)` passes the URL onto the first of its `Deeplinkable`s that can handle this URL.
public final class DeeplinkableComposite: Deeplinkable {
    
    public let deeplinkables: [Deeplinkable]
    
    public init(deeplinkables: [Deeplinkable]) {
        self.deeplinkables = deeplinkables
    }
    
    public func canHandle(url: URL) -> Bool {
        let supportedDeeplinkables = deeplinkables
            .filter { $0.canHandle(url: url) }
            .count
        
        switch supportedDeeplinkables {
        case 1:
            return true
        case _ where supportedDeeplinkables > 1:
            print("[DeeplinkableComposite] warning, more than one deeplinkables can handle the URL: \(url.absoluteString). URL will be handled using the first one in order.")
            return true
        default:
            return false
            
        }
    }
    
    public func deeplink(to url: URL) async throws {
        guard canHandle(url: url),
            let deeplinkable = deeplinkables.first(where: { $0.canHandle(url: url) })
        else { throw NSError(domain: "decodingFailed", code: 1) }
        try await deeplinkable.deeplink(to: url)
    }
}

/// `Deeplinkable` that forms parent - child relationship between 2 `Deeplinkable`s,
/// allowing you together with `DeeplinkableComposite` to form a deeplikable tree structure,
/// where each path of the url is handled by different composable and reusable deeplinkable instance.
///
/// For example: Given that a URL has the following path component - "path1/path2/file",
/// the parent will be given to handle "path1", while the remainder - "path2/file" will be passed over to the child.
/// The child on its own can be a `DeeplinkableTree` or a `DeeplinkableComposite`, enabling you to define
/// a deeplinkable "map" of the whole app, making each screen addressable and, having its path in a separate deeplinkable.
///
/// Authority and scheme part are dropped from url when its passed to `parent` and `children`
public final class DeeplinkableTree: Deeplinkable {
    
    public let parent: Deeplinkable
    public let child: Deeplinkable

    /// `Deeplinkable` that forms parent - child relationship between 2 `Deeplinkable`s,
    /// allowing you together with `DeeplinkableComposite` to form a deeplikable tree structure,
    /// where each path of the url is handled by different composable and reusable deeplinkable instance.
    ///
    /// For example: Given that a URL has the following path component - "path1/path2/file",
    /// the parent will be given to handle "path1", while the remainder - "path2/file" will be passed over to the child.
    /// The child on its own can be a `DeeplinkableTree` or a `DeeplinkableComposite`, enabling you to define
    /// a deeplinkable "map" of the whole app, making each screen addressable and, having its path in a separate deeplinkable.
    public init(parent: Deeplinkable, child: Deeplinkable) {
        self.parent = parent
        self.child = child
    }
    
    /// `Deeplinkable` that forms parent - child relationship between one parent `Deeplinkable`, and multiple children deeplinkables
    ///
    /// For example: Given that a URL has the following path component - "path1/path2/file",
    /// the parent will be given to handle "path1", while the remainder - "path2/file" will be passed over to the child.
    /// The child on its own can be a `DeeplinkableTree` or a `DeeplinkableComposite`, enabling you to define
    /// a deeplinkable "map" of the whole app, making each screen addressable and, having its path in a separate deeplinkable.
    public convenience init(parent: Deeplinkable, children: [Deeplinkable]) {
        self.init(parent: parent, child: DeeplinkableComposite(deeplinkables: children))
    }
    
    public func canHandle(url: URL) -> Bool {
        guard let parentURL = parentURL(from: url) else { return false }
        let parentCan = parent.canHandle(url: parentURL)
        
        guard let childURL = childURL(from: url) else { return parentCan }
        let childCan = child.canHandle(url: childURL)
        
        return parentCan && childCan
    }
    
    public func deeplink(to url: URL) async throws {
        guard canHandle(url: url),
        let parentURL = parentURL(from: url) else {
            throw NSError(domain: "[DeeplinkableTree] unsupported url: \(url.absoluteString)", code: 1)
        }
        
        try await parent.deeplink(to: parentURL)
        
        guard let childURL = childURL(from: url) else { return }
        try await child.deeplink(to: childURL)
    }
    
    private func parentURL(from url: URL) -> URL? {
        if let path = url.pathComponents.first {
            var components = URLComponents(string: path)
            components?.query = url.query
            components?.fragment = url.fragment
            return components?.url
        } else {
            print("[DeeplinkableTree] parent url path unresolved for: \(url.absoluteString)")
            return nil
        }
    }

    private func childURL(from url: URL) -> URL? {
        let components = url.pathComponents.suffix(max(0, url.pathComponents.count - 1))
        guard components.isEmpty == false else { return nil }
        let modifiedPath = components.joined(separator: "/")
        var result = URLComponents(string: modifiedPath)
        result?.query = url.query
        result?.fragment = url.fragment
        return result?.url
    }
}

#endif
