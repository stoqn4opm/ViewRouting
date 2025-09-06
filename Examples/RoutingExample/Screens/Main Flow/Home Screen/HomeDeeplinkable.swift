//
//  HomeDeeplinkable.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 8.09.23.
//  Copyright © 2023 hedgehog lab. All rights reserved.
//

import Foundation

// MARK: - Definition

/// `Deeplinkable` used for navigating to the "home" tab of the main app navigation.
/// Works with the help of `SelectTabRoute`
///
/// In order for the `Deeplinkable` to be executed, the first path component of the url
/// must be "home". 
///
/// Optional query parameter `pop_home_to_root` with values `true/false` is supported
/// controlling whether the navigation stack of home should be popped to root or not.
/// Default value is `false`.
final class HomeDeeplinkable: Deeplinkable {
    
    let selectTabRoute: SelectTabRoute
    
    init(selectTabRoute: SelectTabRoute) {
        self.selectTabRoute = selectTabRoute
    }
    
    func canHandle(url: URL) -> Bool {
        url.pathComponents.first == "home"
    }
    
    @MainActor func deeplink(to url: URL) async throws {
        guard canHandle(url: url) else { throw NSError(domain: "[HomeDeeplinkable] trying to handle unsupported URL: \(url.absoluteString)", code: 1) }
        let popToRoot = URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first { $0.name == "pop_home_to_root" }
        
        selectTabRoute.selectTab(.home, popToRoot: popToRoot?.value == "true")
    }
}
