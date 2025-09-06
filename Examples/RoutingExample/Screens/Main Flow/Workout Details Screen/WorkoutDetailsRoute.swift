//
//  WorkoutDetailsRoute.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation
import SwiftUI

protocol WorkoutDetailsRoute {
    func openWorkout(workout: String)
}

extension WorkoutDetailsRoute where Self: Router {
    
    func openWorkout(workout: String) {
        let router = MainRouter(rootTransition: ModalTransition())
        let viewModel = WorkoutDetailsViewModel(router: router, workout: workout)
        let view = WorkoutDetailsView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        router.root = viewController
        route(to: viewController, as: PushTransition())
    }
}

extension MainRouter: WorkoutDetailsRoute {}
extension RecordingRouter: WorkoutDetailsRoute {}
