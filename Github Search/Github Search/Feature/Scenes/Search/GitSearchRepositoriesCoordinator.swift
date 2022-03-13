//
//  GitSearchRepositoriesCoordinator.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit
import Domain

final class GitSearchRepositoriesCoordinator: Coordinator {
    // MARK: - Private Properties
    private let navigationController: UINavigationController
    private let factory: GitSearchRepoViewControllerFactory
    
    // MARK: - init
    init(navigationController: UINavigationController, factory: GitSearchRepoViewControllerFactory = GitSearchRepoViewControllerFactory()) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    // MARK: - Coordinator Implementation
    func start() {
        let searchViewController = factory.makeGitSearchViewController(navigator: self)
        navigationController.setViewControllers([searchViewController], animated: true)
    }
}

extension GitSearchRepositoriesCoordinator: GitSearchRepoNavigator {
    func showRepositoryBranches(repository: Repository) {
        let branchesViewController = factory.makeBranchesViewController(repository: repository)
        navigationController.pushViewController(branchesViewController, animated: true)
    }
}
