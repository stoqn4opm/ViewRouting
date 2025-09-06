//
//  TabBarItem.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 24/06/22.
//  Copyright © 2022 hedgehog lab. All rights reserved.
//

import Foundation
import UIKit

// MARK: - App Tabs

enum TabBarItem: String, CaseIterable {
    case home
    case discovery
    case profile
}

// MARK: - Helpers

extension TabBarItem: Identifiable {
    
    var id: String { rawValue }
    
    var index: Int {
        switch self {
        case .home:
            return 0
        case .discovery:
            return 1
        case .profile:
            return 2
        }
    }
}
