//
//  ExampleRoutingSchemeDeeplinkable.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 8.09.23.
//  Copyright © 2023 hedgehog lab. All rights reserved.
//

import Foundation


// MARK: - Definition

/// `Deeplinkable` decorator that forwards to decoratee only URL whose scheme is the example app one
final class ExampleRoutingSchemeDeeplinkable: Deeplinkable {

    let decoratee: Deeplinkable
    let scheme: String
    
    init(decoratee: Deeplinkable, scheme: String = "examplerouting") {
        self.decoratee = decoratee
        self.scheme = scheme
    }
    
    func canHandle(url: URL) -> Bool {
        url.scheme == scheme && decoratee.canHandle(url: url)
    }

    func deeplink(to url: URL) async throws {
        if url.scheme == scheme {
            try await decoratee.deeplink(to: url)
        } else {
            throw NSError(domain: "[ExampleRoutingSchemeDeeplinkable] unsupported url: \(url.absoluteString)", code: 1)
        }
    }
}
