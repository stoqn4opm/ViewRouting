//
//  DeeplinkableMap.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 12.09.23.
//  Copyright © 2023 hedgehog lab. All rights reserved.
//

import Foundation



// MARK: - Definition

/// `Deeplinkable` that acts as a centralized place
/// where all deeplink paths that the app supports are defined.
final class DeeplinkableMap: Deeplinkable {
    typealias Routes = SelectTabRoute & WorkoutDetailsRoute & CommentsRoute & SettingsRoute
    
    let routes: Routes
    let router: Router
    let tabAdapter: TabAdapter
    
    init(routes: Routes, router: Router, tabAdapter: TabAdapter) {
        self.routes = routes
        self.router = router
        self.tabAdapter = tabAdapter
    }
    
    func canHandle(url: URL) -> Bool {
        appMap.canHandle(url: url)
    }
    
    func deeplink(to url: URL) async throws {
        try await appMap.deeplink(to: url)
    }
}

// MARK: - App Deeplinkable Map

extension DeeplinkableMap {
    
    private var appMap: Deeplinkable {
        DeeplinkableTree(
            parent: NoOpForwardSlashDeeplinkable(),
            children: [homeMap, discoveryMap, profileMap]
        )
    }
    
    private var homeMap: Deeplinkable {
        browsableAppBranch(withTab: .home)
    }
    
    private var discoveryMap: Deeplinkable {
        browsableAppBranch(withTab: .discovery)
    }
    
    private var profileMap: Deeplinkable {
        DeeplinkableTree(parent: ProfileDeeplinkable(selectTabRoute: routes),
                         child: SettingsDeeplinkable(settingsRoute: routes))
    }
}

// MARK: - Helpers

extension DeeplinkableMap {
    
    private func browsableAppBranch(withTab tab: TabBarItem) -> Deeplinkable {
        let parent: Deeplinkable
        switch tab {
        case .home: parent = HomeDeeplinkable(selectTabRoute: routes)
        case .discovery: parent = DiscoveryDeeplinkable(selectTabRoute: routes)
        case .profile: parent = ProfileDeeplinkable(selectTabRoute: routes)
        }
        
        return DeeplinkableTree(
            parent: ClosureDeeplinkable(decoratee: parent) { [weak self] _ in
                guard let self else { return }
                self.router.root = self.tabAdapter.viewController(for: tab)
            },
            children: [workoutBranch, commentsBranch]
        )
    }
    
    private var workoutBranch: Deeplinkable {
        DeeplinkableTree(
            parent: WorkoutDetailsDeeplinkable(workoutDetailsRoute: routes),
            child: commentsBranch
        )
    }
    
    private var commentsBranch: Deeplinkable {
        CommentsDeeplinkable(commentsRoute: routes)
    }
}
