//
//  CommentsRoute.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation
import SwiftUI

protocol CommentsRoute {
    func openComment(_ comment: String)
}

extension CommentsRoute where Self: Router {
    
    func openComment(_ comment: String) {
        let viewModel = CommentsViewModel(comment: comment)
        let view = CommentsView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        route(to: viewController, as: PushTransition())
    }
}

extension MainRouter: CommentsRoute {}
extension RecordingRouter: CommentsRoute {}
