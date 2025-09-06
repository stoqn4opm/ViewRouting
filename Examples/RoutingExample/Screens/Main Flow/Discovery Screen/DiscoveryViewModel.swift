//
//  DiscoveryViewModel.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation
import SwiftUI

// MARK: - Class Definition

final class DiscoveryViewModel: ObservableObject {

    typealias Routes = WorkoutDetailsRoute

    let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
}

// MARK: - User Actions

extension DiscoveryViewModel {
    func openWorkout() {
        router.openWorkout(workout: "example workout from Discovery")
    }
}
