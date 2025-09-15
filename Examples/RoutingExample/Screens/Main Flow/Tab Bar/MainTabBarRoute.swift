//
//  MainTabBarRoute.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 24/06/22.
//  Copyright © 2022 hedgehog lab. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Route Definition

protocol MainTabBarRoute {
    func loadMainAppInterface(selectedTab tab: TabBarItem) -> UIViewController
}

extension MainTabBarRoute where Self: Router {
    
    func loadMainAppInterface(selectedTab tab: TabBarItem) -> UIViewController {
        let controller = composeTabBarController(selectedTab: tab)
        MainTabBarAccessor().setMainTabBar(controller)
        root = controller
        return controller
    }
}

// MARK: - Helpers

extension MainTabBarRoute where Self: Routable {
    
    @discardableResult
    private func composeTabBarController(selectedTab tab: TabBarItem) -> MainTabBarController {
        let mainRouter = MainRouter(rootTransition: EmptyTransition())
        let tabs = composeTabs(from: mainRouter)
        let sortedTabs = tabs.sorted { $0.key.index < $1.key.index }
        
        let selection = MainTabBarSelectionHolder(allTabs: sortedTabs.map { $0.key })
        let tabBarController = MainTabBarController(allTabs: sortedTabs,
                                                    selection: selection)
        
        route(to: tabBarController, as: RootControllerCrossDissolveTransition(windowProvider: ActiveSceneFirstWindowProvider()))
        mainRouter.root = tabBarController
        selection.selectedTab = tab
        return tabBarController
    }
    
    private func composeTabs(from mainRouter: MainRouter) -> [TabBarItem: UIViewController] {
        let tabs = TabBarItem.allCases
            .map { tab -> (tab: TabBarItem, controller: UIViewController) in
                switch tab {
                case .home:
                    return (tab: tab, controller: mainRouter.composeHomeTab())
                case .discovery:
                    return (tab: tab, controller: mainRouter.composeDiscoveryTab())
                case .profile:
                    return (tab: tab, controller: mainRouter.composeProfileTab())
                }
            }
        
        return Dictionary(uniqueKeysWithValues: tabs)
    }
}

// MARK: - Supported Routers

extension DefaultRouter: MainTabBarRoute { }
