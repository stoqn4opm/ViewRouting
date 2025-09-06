//
//  WorkoutDetailsView.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import SwiftUI

struct WorkoutDetailsView: View {
    
    @ObservedObject var viewModel: WorkoutDetailsViewModel

    var body: some View {
        VStack {
            Text("WorkoutDetails for: \(viewModel.workout)")
            Button("Open comment") {
                viewModel.openComments()
            }
        }
    }
}

// MARK: - Preview

struct WorkoutDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailsView(viewModel: WorkoutDetailsViewModel(router: WorkoutDetailsScreenRoutesMock(), workout: "workout model"))
    }
}

final class WorkoutDetailsScreenRoutesMock: WorkoutDetailsViewModel.Routes {
    func openComment(_ comment: String) { }
}
