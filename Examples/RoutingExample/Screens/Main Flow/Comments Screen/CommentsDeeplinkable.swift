//
//  CommentsDeeplinkable.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import Foundation

// MARK: - Definition

/// Deeplinkable that can navigate the user to a comments page of a workout
final class CommentsDeeplinkable: Deeplinkable {
    
    let commentsRoute: CommentsRoute
    
    init(commentsRoute: CommentsRoute) {
        self.commentsRoute = commentsRoute
    }
    
    func canHandle(url: URL) -> Bool {
        url.pathComponents.first == "comment" && comment(from: url) != nil
    }
    
    @MainActor func deeplink(to url: URL) async throws {
        guard canHandle(url: url), let comment = comment(from: url) else {
            throw NSError(domain: "[CommentsDeeplinkable] unsupported url: \(url.absoluteString)", code: 1)
        }
        
        commentsRoute.openComment(comment)
    }
    
    private func comment(from url: URL) -> String? {
        URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first { $0.name == "comment_message" }?
            .value
    }
}
