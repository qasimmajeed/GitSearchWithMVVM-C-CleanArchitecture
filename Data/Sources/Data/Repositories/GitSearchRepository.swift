//
//  GitSearchRepository.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation
import Domain
import Network_Feature
import Combine

public struct GitSearchRepository: GitSearchRepositoryProtocol {
    // MARK: - Private Properties
    private let network: Networking
    
    // MARK: - init
    public init(network: Networking = Network()) {
        self.network = network
    }
    
    // MARK: - GitSearchRepositoryProtocol Implementation
    public func fetchGitRepositories(bySearch search: GitSearchRequest) -> AnyPublisher<[Repository], Error> {
        let requestBuilder = APIRequestBuilder(host: DataConstants.APIUrls.baseURL,
                                               path: DataConstants.APIPaths.searchRepositories,
                                               parameters: search,
                                               headers: ["Authorization": DataConstants.APIData.apiToken])
        return self.network.request(request: requestBuilder)
            .mapError { $0 }
            .map { ($0 as SearchResponse).items }
            .eraseToAnyPublisher()
    }
    
    public func fetchRepositoryBranches(request: RepoBranchRequest) -> AnyPublisher<[Branch], Error> {
        let path = String(format: DataConstants.APIPaths.branches, request.repoName)
        let requestBuilder = APIRequestBuilder(host: DataConstants.APIUrls.baseURL,
                                               path: path,
                                               parameters: request.param,
                                               headers: ["Authorization": DataConstants.APIData.apiToken])
        return self.network.request(request: requestBuilder)
            .mapError { $0 }
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
