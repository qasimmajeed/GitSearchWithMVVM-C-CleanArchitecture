//
//  GitSearchUseCaseProtocol.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation
import Combine

public protocol GitSearchUseCaseProtocol {
    /// This will search the git repositories  by given `search`.
    /// - Parameters
    ///     - search:  Search for the repo by the name.
    /// - Returns  AnyPublisher: with the repositories or in the case of error
    func searchGitRepositories(_ search: GitSearchRequest) -> AnyPublisher<[Repository], Error>
    
    /// This will get the branches for given repository `request`.
    /// - Parameters
    ///     - request:  Information related to repo.
    /// - Returns  AnyPublisher: with the Branch or in the case of error
    func getRepositoryBranches(request: RepoBranchRequest) -> AnyPublisher<[Branch], Error>
}
