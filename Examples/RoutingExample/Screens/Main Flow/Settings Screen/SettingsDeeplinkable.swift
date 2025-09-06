//
//  SettingsDeeplinkable.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation

// MARK: - Definition

/// Deeplinkable that can navigate the user to a settings page of a workout
final class SettingsDeeplinkable: Deeplinkable {
    
    let settingsRoute: SettingsRoute
    
    init(settingsRoute: SettingsRoute) {
        self.settingsRoute = settingsRoute
    }
    
    func canHandle(url: URL) -> Bool {
        url.pathComponents.first == "settings"
    }
    
    @MainActor func deeplink(to url: URL) async throws {
        guard canHandle(url: url) else {
            throw NSError(domain: "[SettingsDeeplinkable] unsupported url: \(url.absoluteString)", code: 1)
        }
        
        settingsRoute.openSettings()
    }
}
