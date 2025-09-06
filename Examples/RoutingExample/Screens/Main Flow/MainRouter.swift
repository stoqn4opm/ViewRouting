//
//  MainRouter.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 24/06/22.
//  Copyright © 2022 hedgehog lab. All rights reserved.
//

import Foundation

// MARK: - Main Router

/// Router that deals with screen routing within the main app flow.
final class MainRouter: DefaultRouter {
    private let tabBarProvider: MainTabBarProvider
    
    init(rootTransition: Transition,
         tabBarProvider: MainTabBarProvider = MainTabBarAccessor()) {
        self.tabBarProvider = tabBarProvider
        super.init(rootTransition: rootTransition)
    }
}

// MARK: - Interface

extension MainRouter {
    
    var mainTabBar: MainTabBarController? {
        tabBarProvider.mainTabBar
    }
}
