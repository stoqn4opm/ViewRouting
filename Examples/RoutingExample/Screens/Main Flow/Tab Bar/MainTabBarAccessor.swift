//
//  MainTabBarAccessor.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 17/10/22.
//  Copyright © 2022 hedgehog lab. All rights reserved.
//

import Foundation
import Combine

// MARK: - Setter Interface

/// A protocol that abstracts away the act of setting `MainTabBarController`
/// instance to all `MainTabBarProvider`s.
protocol MainTabBarSetter {
    func setMainTabBar(_ mainTabBar: MainTabBarController)
}

// MARK: - Getter Interface

/// A protocol that abstracts away the act of receiving `MainTabBarController`
/// from a `MainTabBarSetter` instance.
protocol MainTabBarProvider {
    var mainTabBar: MainTabBarController? { get }
}

// MARK: - Static Reference Based Implementation

final class MainTabBarAccessor: MainTabBarSetter, MainTabBarProvider {
    
    private static weak var sharedMainTabBar: MainTabBarController?
    
    var mainTabBar: MainTabBarController? {
        Self.sharedMainTabBar
    }
    
    func setMainTabBar(_ mainTabBar: MainTabBarController) {
        Self.sharedMainTabBar = mainTabBar
    }
}
