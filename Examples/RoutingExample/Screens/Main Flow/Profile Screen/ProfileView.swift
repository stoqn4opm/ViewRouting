//
//  ProfileView.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import SwiftUI

struct ProfileView: View {

    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            Text("Profile")
            Button("Open Settings") {
                viewModel.openSettings()
            }
        }
    }
}

// MARK: - Preview

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: .init(router: ProfileRoutesMock()))
    }
}

final class ProfileRoutesMock: ProfileViewModel.Routes {
    func openSettings() { }
}
