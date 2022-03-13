//
//  SceneDelegate.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public Properties
    var window: UIWindow?
    
    // MARK: - Private Properties
    /// It will hold the app coordinator to start the flow of application.
    private var coordinator: AppCoordinator?
    
    // MARK: - Public Methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let coordinator = AppCoordinator(window: window)
        self.window = window
        self.coordinator = coordinator
        coordinator.start()
    }
}
