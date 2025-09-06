//
//  ProfileRoute.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation
import SwiftUI

protocol ProfileRoute {
    func composeProfileTab() -> UIViewController
}

extension ProfileRoute where Self: Router {
    
    func composeProfileTab() -> UIViewController {
        let router = MainRouter(rootTransition: ModalTransition())
        let viewModel = ProfileViewModel(router: router)
        let view = ProfileView(viewModel: viewModel)
        let viewController = UINavigationController(rootViewController: UIHostingController(rootView: view))
        viewController.title = "Profile"
        router.root = viewController
        return viewController
    }
}

extension MainRouter: ProfileRoute {}
