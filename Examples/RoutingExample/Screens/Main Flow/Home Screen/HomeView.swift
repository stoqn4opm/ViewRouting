//
//  HomeView.swift
//  RoutingExample
//
//  Created by vlad on 18/05/2022.
//  Copyright © 2022 hedgehog lab. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack {
            Text("Home")
            Button("Open Workout") {
                viewModel.openWorkout()
            }
        }
    }
}

// MARK: - Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(router: HomeScreenRoutesMock()))
    }
}

final class HomeScreenRoutesMock: HomeViewModel.Routes {
    func openWorkout(workout: String) { }
}
