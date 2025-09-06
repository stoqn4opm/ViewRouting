//
//  MainTabBarController.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 24/06/22.
//  Copyright © 2022 hedgehog lab. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Combine

// MARK: - Class Definition

final class MainTabBarController: UIViewController, ObservableObject {
    
    /// Observed object that holds the tab's information including selection.
    let selection: MainTabBarSelectionHolder
    
    private let tabContent: UITabBarController
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(allTabs: [(key: TabBarItem, value: UIViewController)],
         selection: MainTabBarSelectionHolder) {
        
        self.selection = selection
        self.tabContent = UITabBarController(nibName: nil, bundle: nil)
        let tabViewControllers = allTabs.map { $0.value }
        tabViewControllers.forEach { $0.view.layoutIfNeeded() }
        self.tabContent.viewControllers = tabViewControllers
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        self.tabContent = UITabBarController(nibName: nil, bundle: Bundle(for: MainTabBarController.self))
        self.selection = MainTabBarSelectionHolder(allTabs: [])
        super.init(coder: coder)
    }
}

// MARK: - Controller Lifecycle

extension MainTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabContent()
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        selection.$selectedTab
            .sink { [weak self] tab in
                self?.tabContent.selectedIndex = tab.index
            }
            .store(in: &cancellables)
    }
    
    func popToRoot(for tab: TabBarItem) {
        guard let indexOfTab = selection.tabs.firstIndex(of: tab) else { return }
        (tabContent.children[indexOfTab] as? UINavigationController)?.popToRootViewController(animated: true)
    }
    
    func viewController(for tab: TabBarItem) -> UIViewController? {
        guard let indexOfTab = selection.tabs.firstIndex(of: tab) else { return nil }
        return tabContent.children[indexOfTab] as? UINavigationController
    }
}

// MARK: - Helpers

extension MainTabBarController {
    
    private func prepareTabContent() {
        embed(tabContent)
    }
    
    /// Embeds easily a view controller inside this one. if called multiple time **pay attention to call** `children.forEach { $0.removeFromParent() }` **when appropriate**
    ///
    /// - Parameters:
    ///   - viewController: the view controller you want to embed.
    ///   - containerView: the view in which you want your view controller visible, if `nil`, the view controller's main `view` is used.
    private func embed(_ viewController: UIViewController, in containerView: UIView? = nil) {
        guard let containerView = containerView ?? view else { return }
        addChild(viewController)
        
        containerView.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: viewController.view as Any, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: viewController.view as Any, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: viewController.view as Any, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1, constant: 0)
        let down = NSLayoutConstraint(item: viewController.view as Any, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)
        
        containerView.addConstraints([top, left, right, down])
        viewController.didMove(toParent: self)
    }
}
