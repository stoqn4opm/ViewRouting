//
//  WorkoutDetailsViewModel.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation
import SwiftUI

// MARK: - Class Definition

final class WorkoutDetailsViewModel: ObservableObject {

    typealias Routes = CommentsRoute

    let router: Routes
    let workout: String
    
    init(router: Routes, workout: String) {
        self.router = router
        self.workout = workout
    }
}

// MARK: - User Actions

extension WorkoutDetailsViewModel {
    func openComments() { 
        router.openComment("comment for workout: \(workout)")
    }
}
