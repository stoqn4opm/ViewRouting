//
//  DiscoveryRoute.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation
import SwiftUI

protocol DiscoveryRoute {
    func composeDiscoveryTab() -> UIViewController
}

extension DiscoveryRoute where Self: Router {
    
    func composeDiscoveryTab() -> UIViewController {
        let router = MainRouter(rootTransition: ModalTransition())
        let viewModel = DiscoveryViewModel(router: router)
        let view = DiscoveryView(viewModel: viewModel)
        let viewController = UINavigationController(rootViewController: UIHostingController(rootView: view))
        router.root = viewController
        viewController.title = "Discovery"
        return viewController
    }
    
}

extension MainRouter: DiscoveryRoute {}
