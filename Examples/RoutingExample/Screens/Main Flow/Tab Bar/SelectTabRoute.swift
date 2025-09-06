//
//  SelectTabRoute.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 04/07/22.
//  Copyright © 2022 hedgehog lab. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Route Definition

protocol SelectTabRoute {
    func selectTab(_ tab: TabBarItem)
    func selectTab(_ tab: TabBarItem, popToRoot: Bool)
}

// MARK: - Route Defaults

extension SelectTabRoute where Self: Router {
  
    func selectTab(_ tab: TabBarItem) {
        guard let controller = root as? MainTabBarController else { return }
        controller.selection.selectedTab = tab
    }
    
    func selectTab(_ tab: TabBarItem, popToRoot: Bool) {
        self.selectTab(tab)
        if popToRoot {
            guard let controller = root as? MainTabBarController else { return }
            controller.popToRoot(for: tab)
        }
    }
}

// MARK: - Supported Routers

extension MainRouter: SelectTabRoute {
    
    func selectTab(_ tab: TabBarItem) {
        mainTabBar?.selection.selectedTab = tab
    }
    
    func selectTab(_ tab: TabBarItem, popToRoot: Bool) {
        selectTab(tab)
        guard popToRoot else { return }
        mainTabBar?.popToRoot(for: tab)
    }
}

extension RecordingRouter: SelectTabRoute {
    
    func selectTab(_ tab: TabBarItem) {
        if let decoratee = decoratee as? SelectTabRoute {
            route(to: .init(), as: EmptyTransition(invokeCompletion: true)) {
                decoratee.selectTab(tab)
            }
        } else {
            guard let controller = root as? MainTabBarController else { return }
            route(to: .init(), as: EmptyTransition(invokeCompletion: true)) {
                controller.selection.selectedTab = tab
            }
        }
    }
    
    func selectTab(_ tab: TabBarItem, popToRoot: Bool) {
        if let decoratee = decoratee as? SelectTabRoute {
            route(to: .init(), as: EmptyTransition(invokeCompletion: true)) {
                decoratee.selectTab(tab, popToRoot: popToRoot)
            }
        } else {
            selectTab(tab)
            if popToRoot {
                guard let controller = root as? MainTabBarController else { return }
                route(to: .init(), as: EmptyTransition(invokeCompletion: true)) {
                    controller.popToRoot(for: tab)
                }
            }
        }
    }
}
