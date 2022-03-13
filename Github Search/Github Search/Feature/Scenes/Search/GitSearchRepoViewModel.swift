//
//  GitSearchRepoViewModel.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import Domain
import Combine

protocol GitSearchRepoNavigator: class {
    func showRepositoryBranches(repository: Repository)
}

/// States For View Model
enum GitSearchViewModelState {
    case showRepositories([GitSearchCellViewItem])
    case error(String)
    case showIndicator(Bool)
}

final class GitSearchRepoViewModel {
    // MARK: - Private Properties
    private var repositories: [Repository] = [Repository]()
    private let navigator: GitSearchRepoNavigator
    private let useCase: GitSearchUseCaseProtocol
    private let stateDidUpdateSubject = PassthroughSubject<GitSearchViewModelState, Never>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Public Properties
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()
    public var title: String = "Search Repositories"
    public var searchWaitMilliSecond: Int = 500
    
    // MARK: - Init
    init(useCase: GitSearchUseCaseProtocol, navigator: GitSearchRepoNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    // MARK: - Private methods
    private func searchRepository(_ searchText: String) {
        stateDidUpdateSubject.send(.showIndicator(true))
        stateDidUpdateSubject.send(.showRepositories([]))
        let searchRequest = GitSearchRequest(searchQuery: searchText, page: 1, pageSize: 10)
        useCase.searchGitRepositories(searchRequest).sink { [weak self] completion in
            guard let self = self else { return }
            self.stateDidUpdateSubject.send(.showIndicator(false))
            switch completion {
            case .finished: break
            case .failure(let error):
                self.stateDidUpdateSubject.send(.error(error.localizedDescription))
            }
        } receiveValue: { [weak self] repositories in
            guard let self = self else { return }
            
            self.stateDidUpdateSubject.send(.showIndicator(false))
            self.repositories = repositories
            let viewItems = self.repositories.map { self.createListCellViewModel(with: $0)}
            self.stateDidUpdateSubject.send(.showRepositories(viewItems))
        }.store(in: &cancellable)
    }
    
    private func createListCellViewModel(with repository: Repository) -> GitSearchCellViewItem {
        return GitSearchCellViewItem(repository: repository)
    }
    
    // MARK: - Public Methods
    public func searchTextChange(searchText: String) {
        if searchText != "" {
            searchRepository(searchText)
        }
    }
    
    public func didSelet(index: Int) {
        guard  self.repositories.count > index else {
            return
        }
        let repository =  self.repositories[index]
        if repository.branches.count > 0 {
            navigator.showRepositoryBranches(repository: self.repositories[index])
        }
    }
}
