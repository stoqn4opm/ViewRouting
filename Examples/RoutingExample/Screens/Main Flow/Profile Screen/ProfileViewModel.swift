//
//  ProfileViewModel.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation
import SwiftUI

// MARK: - Class Definition

final class ProfileViewModel: ObservableObject {

    typealias Routes = SettingsRoute
    
    let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func openSettings() {
        router.openSettings()
    }
}
