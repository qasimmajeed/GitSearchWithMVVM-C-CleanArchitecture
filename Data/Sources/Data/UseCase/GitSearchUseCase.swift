//
//  GitSearchUseCase.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation
import Domain
import Combine
import Network_Feature

final public class GitSearchUseCase: GitSearchUseCaseProtocol {
    // MARK: - Private Properties
    private let repository: GitSearchRepositoryProtocol
    
    // MARK: - init
    public init(repository: GitSearchRepositoryProtocol = GitSearchRepository()) {
        self.repository = repository
    }
    
    // MARK: - GitSearchUseCaseProtocol Implementation
    public func searchGitRepositories(_ search: GitSearchRequest) -> AnyPublisher<[Repository], Error> {
        let repositoriesPublisher =  repository.fetchGitRepositories(bySearch: search)
            .map { $0 }
            .mapError { $0 }
            .eraseToAnyPublisher()
        
        return repositoriesPublisher
            .flatMap { $0.publisher }
            .flatMap { repository in
                self.loadAllBranchesPage(request: RepoBranchRequest(repoName: repository.fullName, param: RepoBranchRequestParam(page: 1, pageSize: 100)))
                    .flatMap { $0.publisher }
                    .collect()
                    .map { branches in
                        var repository = repository
                        repository.branches = branches
                        return repository
                    }
            }
            .collect()
            .eraseToAnyPublisher()
    }
    
    public func getRepositoryBranches(request: RepoBranchRequest) -> AnyPublisher<[Branch], Error> {
        return repository.fetchRepositoryBranches(request: request)
            .mapError { $0 }
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private Methods
    private func loadAllBranchesPage(request:  RepoBranchRequest) -> AnyPublisher<[Branch], Error> {
        let pageIndexPublisher = CurrentValueSubject<RepoBranchRequest, Error>(request)
        return pageIndexPublisher.flatMap({ request in
            return self.repository.fetchRepositoryBranches(request: request)
        }).handleEvents(receiveOutput: { (response: [Branch]) in
            if response.count > 0 {
                var page: RepoBranchRequest = pageIndexPublisher.value
                page.param.page += 1
                pageIndexPublisher.send(page)
            } else {
                pageIndexPublisher.send(completion: .finished)
            }
        }).reduce([Branch](), { allItems, response in
            return response + allItems
        }).mapError { $0 }
        .eraseToAnyPublisher()
    }
}
