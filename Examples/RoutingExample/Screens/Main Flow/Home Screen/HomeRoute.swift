//
//  HomeRoute.swift
//  RoutingExample
//
//  Created by vlad on 18/05/2022.
//  Copyright © 2022 hedgehog lab. All rights reserved.
//

import Foundation
import SwiftUI

protocol HomeRoute {
    func composeHomeTab() -> UIViewController
}

extension HomeRoute where Self: Router {
    
    func composeHomeTab() -> UIViewController {
        let router = MainRouter(rootTransition: EmptyTransition())
        let viewModel = HomeViewModel(router: router)
        let view = HomeView(viewModel: viewModel)
        let viewController = UINavigationController(rootViewController: UIHostingController(rootView: view))
        router.root = viewController
        viewController.title = "Home"
        return viewController
    }
    
}

extension MainRouter: HomeRoute {}
