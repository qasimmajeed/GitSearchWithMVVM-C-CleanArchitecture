//
//  GitSearchRepoViewControllerFactory.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit
import Domain
import Data

/// This class is responsible for creation of all the object related to GitSearchRepoViewController
final class GitSearchRepoViewControllerFactory {
    // MARK: - Private Properties
    private let useCase: GitSearchUseCaseProtocol
    
    // MARK: - Init
    init(useCase: GitSearchUseCaseProtocol = GitSearchUseCase() ) {
        self.useCase = useCase
    }
    
    // MARK: - Public Methods
    func makeGitSearchViewController(navigator: GitSearchRepoNavigator) -> GitSearchRepositoriesViewController {
        let storyboard = UIStoryboard(name: .GitRepository, bundle: Bundle.main)
        let viewModel = GitSearchRepoViewModel(useCase: useCase, navigator: navigator)
        let viewController: GitSearchRepositoriesViewController = storyboard.instantiateViewController(identifier: GitSearchRepositoriesViewController.storyboardID()) {
            GitSearchRepositoriesViewController(coder: $0, viewModel: viewModel)
        }
        return viewController
    }
    
    func makeBranchesViewController(repository: Repository) -> BranchesViewController {
        let storyboard = UIStoryboard(name: .GitRepository, bundle: Bundle.main)
        let viewModel = BranchesViewModel(repository: repository)
        let viewController: BranchesViewController = storyboard.instantiateViewController(identifier: BranchesViewController.storyboardID()) {
            BranchesViewController(coder: $0, viewModel: viewModel)
        }
        return viewController
    }
}
