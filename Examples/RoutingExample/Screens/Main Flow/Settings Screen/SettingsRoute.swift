//
//  SettingsRoute.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation
import SwiftUI

protocol SettingsRoute {
    func openSettings()
}

extension SettingsRoute where Self: Router {
    
    func openSettings() {
        let view = SettingsView()
        let viewController = UIHostingController(rootView: view)
        route(to: viewController, as: ModalTransition())
    }
}

extension MainRouter: SettingsRoute {}
extension RecordingRouter: SettingsRoute {}
