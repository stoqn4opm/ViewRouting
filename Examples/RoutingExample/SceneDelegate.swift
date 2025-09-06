//
//  SceneDelegate.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        prepareWindow(scene: scene)
        guard let context = connectionOptions.urlContexts.first else { return }
        handleLinkIfPresent(urlContext: context)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let context = URLContexts.first else { return }
        handleLinkIfPresent(urlContext: context)
    }
}

// MARK: - App Composition

extension SceneDelegate {
    
    private func prepareWindow(scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        window.rootViewController = composeRootViewController(for: window)
    }
    
    private func composeRootViewController(for window: UIWindow) -> UIViewController {
        let router = DefaultRouter(rootTransition: RootControllerCrossDissolveTransition())
        let controller = router.loadMainAppInterface(selectedTab: .home)
        
        return controller
    }
}

// MARK: - Deeplinking

extension SceneDelegate {
 
    func handleLinkIfPresent(urlContext: UIOpenURLContext) {
        let sendingAppID = urlContext.options.sourceApplication
        let url = urlContext.url
        print("source application = \(sendingAppID ?? "Unknown")")
        print("url = \(url)")
        
        let router = MainRouter(rootTransition: EmptyTransition())
        router.root = window?.rootViewController
        
        let deeplinkHandler = RecordingRouter(decoratee: router)
        
//        guard deeplinkHandler.canHandle(url: url) else { return }
        
        Task {
            do {
                try await deeplinkHandler.deeplink(to: url)
            } catch {
                print(error)
            }
        }
    }
}
