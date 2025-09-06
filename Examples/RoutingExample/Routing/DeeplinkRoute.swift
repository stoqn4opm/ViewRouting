//
//  DeeplinkRoute.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 12.09.23.
//  Copyright © 2023 hedgehog lab. All rights reserved.
//

import Foundation

// MARK: - Definition

protocol DeeplinkRoute: Deeplinkable { }

// MARK: - Default Implementation

extension DeeplinkRoute where Self: DeeplinkableMap.Routes & Router & TabAdapter & Executable {
    
    func canHandle(url: URL) -> Bool {
        appMap.canHandle(url: url)
    }
    
    func deeplink(to url: URL) async throws {
        try await appMap.deeplink(to: url)
    }
    
    private var appMap: Deeplinkable {
        let appMap = DeeplinkableMap(routes: self, router: self, tabAdapter: self)
        let linkExecutor = ExecutingDeeplinkable(decoratee: appMap, executable: self)
        let schemeCheck = ExampleRoutingSchemeDeeplinkable(decoratee: linkExecutor)
        let httpAndAppComposite = DeeplinkableComposite(deeplinkables: [schemeCheck, HTTPSDeeplinkable()])
        return httpAndAppComposite
    }
}

// MARK: - Supported Routers

extension RecordingRouter: @retroactive Deeplinkable {}
extension RecordingRouter: DeeplinkRoute {
    
    public func canHandle(url: URL) -> Bool {
        appMap.canHandle(url: url)
    }
    
    public func deeplink(to url: URL) async throws {
        try await appMap.deeplink(to: url)
    }
    
    private var appMap: Deeplinkable {
        let appMap = DeeplinkableMap(routes: self, router: self, tabAdapter: self)
        let linkExecutor = ExecutingDeeplinkable(decoratee: appMap, executable: self)
        let schemeCheck = ExampleRoutingSchemeDeeplinkable(decoratee: linkExecutor)
        let httpAndAppComposite = DeeplinkableComposite(deeplinkables: [schemeCheck, HTTPSDeeplinkable()])
        return httpAndAppComposite
    }
}
