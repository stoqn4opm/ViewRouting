//
//  HomeViewModel.swift
//  RoutingExample
//
//  Created by vlad on 18/05/2022.
//  Copyright © 2022 hedgehog lab. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Class Definition

final class HomeViewModel: ObservableObject {

    typealias Routes = WorkoutDetailsRoute

    let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
}

// MARK: - User Actions

extension HomeViewModel {
    func openWorkout() { 
        router.openWorkout(workout: "example workout from home")
    }
}
