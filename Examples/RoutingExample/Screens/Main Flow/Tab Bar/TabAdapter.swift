//
//  TabAdapter.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 5.09.23.
//  Copyright © 2023 hedgehog lab. All rights reserved.
//

import UIKit

// MARK: - Adapter Definition

/// Object that converts `TabBarItem`s into `UIViewController`.
/// Used for accessing the main tab bar root controllers in the app.
protocol TabAdapter {
    
    /// Converts tabs to view controllers.
    ///
    /// - Parameter tab: The tab for which you want view controller.
    /// - Returns: The view controller related to this tab.
    func viewController(for tab: TabBarItem) -> UIViewController?
}

// MARK: - Default Implementation

extension TabAdapter where Self: Router {
    
    func viewController(for tab: TabBarItem) -> UIViewController? {
        (root as? MainTabBarController)?.viewController(for: tab)
    }
}

// MARK: - Supported Routers

extension MainRouter: TabAdapter {
    
    func viewController(for tab: TabBarItem) -> UIViewController? {
        mainTabBar?.viewController(for: tab)
    }
}

extension RecordingRouter: TabAdapter {
    
    func viewController(for tab: TabBarItem) -> UIViewController? {
        if let decoratee = decoratee as? TabAdapter {
            return decoratee.viewController(for: tab)
        } else {
            return (root as? MainTabBarController)?.viewController(for: tab)
        }
    }
}
