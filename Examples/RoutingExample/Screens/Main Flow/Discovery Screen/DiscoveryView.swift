//
//  DiscoveryView.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import SwiftUI

struct DiscoveryView: View {
    
    @ObservedObject var viewModel: DiscoveryViewModel

    var body: some View {
        VStack {
            Text("Discovery")
            Button("Open Workout") {
                viewModel.openWorkout()
            }
        }
    }
}

// MARK: - Preview

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryView(viewModel: DiscoveryViewModel(router: DiscoveryScreenRoutesMock()))
    }
}

final class DiscoveryScreenRoutesMock: DiscoveryViewModel.Routes {
    func openWorkout(workout: String) { }
}
