//
//  AppCoordinator.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit

final class AppCoordinator: Coordinator {
    // MARK: - Private Properties
    private let window: UIWindow
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Coordinator Implementation
    func start() {
        let navigationController = UINavigationController()
        let searchCoordinator = GitSearchRepositoriesCoordinator(navigationController: navigationController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        searchCoordinator.start()
    }
}
