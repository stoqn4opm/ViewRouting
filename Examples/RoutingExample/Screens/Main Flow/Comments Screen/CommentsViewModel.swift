//
//  CommentsViewModel.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation
import SwiftUI

// MARK: - Class Definition

final class CommentsViewModel: ObservableObject {

    let comment: String
    
    init(comment: String) {
        self.comment = comment
    }
}
