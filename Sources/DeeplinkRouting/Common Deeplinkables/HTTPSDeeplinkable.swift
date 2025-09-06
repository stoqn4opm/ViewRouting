//
//  File.swift
//  ViewRouting
//
//  Created by stoyan on 6.09.25.
//

#if canImport(UIKit)

import Foundation
import UIKit

// MARK: - Definition

/// `Deeplinkable` that opens a https links in the device's web browser
public final class HTTPSDeeplinkable: Deeplinkable {

    public let application: UIApplication
    
    public init(application: UIApplication = .shared) {
        self.application = application
    }
    
    public func canHandle(url: URL) -> Bool {
        url.scheme == "https"
    }

    @MainActor
    public func deeplink(to url: URL) async throws {
        if url.scheme == "https" {
            await application.open(url)
        } else {
            throw NSError(domain: "[HTTPSDeeplinkable] unsupported url: \(url.absoluteString)", code: 1)
        }
    }
}

#endif
