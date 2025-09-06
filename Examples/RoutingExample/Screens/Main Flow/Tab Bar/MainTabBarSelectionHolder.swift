//
//  MainTabBarSelectionHolder.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 6.07.23.
//  Copyright © 2023 hedgehog lab. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Class Definition

final class MainTabBarSelectionHolder: ObservableObject {
    
    /// Place where all tab items are stored from where selection can be made.
    let tabs: [TabBarItem]
    
    /// From here you can set programmatically which tab to be selected.
    @Published var selectedTab: TabBarItem
    
    init(allTabs: [TabBarItem], selectedTab: TabBarItem = .home) {
        self.tabs = allTabs
        self.selectedTab = selectedTab
    }
}
