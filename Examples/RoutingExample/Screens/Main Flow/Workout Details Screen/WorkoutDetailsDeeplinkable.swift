//
//  WorkoutDetailsDeeplinkable.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation

// MARK: - Definition

/// `Deeplinkable` that opens workout details
/// The id of the workout should be passed as query parameter `workout_id`
class WorkoutDetailsDeeplinkable: Deeplinkable {
    
    let workoutDetailsRoute: WorkoutDetailsRoute
    
    init(workoutDetailsRoute: WorkoutDetailsRoute) {
        self.workoutDetailsRoute = workoutDetailsRoute
    }

    func canHandle(url: URL) -> Bool {
        url.pathComponents.first == "workout" && workoutModel(from: url) != nil
    }
    
    @MainActor func deeplink(to url: URL) async throws {
        guard canHandle(url: url), let workoutModel = workoutModel(from: url) else {
            throw NSError(domain: "[WorkoutDetailsDeeplinkable] unsupported url: \(url.absoluteString)", code: 1)
        }
        
        workoutDetailsRoute.openWorkout(workout: workoutModel)
    }
    
    private func workoutModel(from url: URL) -> String? {
        URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first { $0.name == "workout_model" }?
            .value
    }
}
