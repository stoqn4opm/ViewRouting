//
//  ProfileDeeplinkable.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation

// MARK: - Definition

/// `Deeplinkable` used for navigating to the "profile" tab of the main app navigation.
/// Works with the help of `SelectTabRoute`
///
/// In order for the `Deeplinkable` to be executed, the first path component of the url
/// must be "profile".
///
/// Optional query parameter `pop_profile_to_root` with values `true/false` is supported
/// controlling whether the navigation stack of profile should be popped to root or not.
/// Default value is `false`.
final class ProfileDeeplinkable: Deeplinkable {
    
    let selectTabRoute: SelectTabRoute
    
    init(selectTabRoute: SelectTabRoute) {
        self.selectTabRoute = selectTabRoute
    }
    
    func canHandle(url: URL) -> Bool {
        url.pathComponents.first == "profile"
    }
    
    @MainActor func deeplink(to url: URL) async throws {
        guard canHandle(url: url) else { throw NSError(domain: "[ProfileDeeplinkable] trying to handle unsupported URL: \(url.absoluteString)", code: 1) }
        let popToRoot = URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first { $0.name == "pop_profile_to_root" }
        
        selectTabRoute.selectTab(.profile, popToRoot: popToRoot?.value == "true")
    }
}
