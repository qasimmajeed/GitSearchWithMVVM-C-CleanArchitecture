//
//  GitSearchUseCaseMock.swift
//  Github SearchTests
//
//  Created by Qasim Majeed on 27.02.22.
//

import Domain
import Combine
import Network_Feature

@testable import Github_Search

final class GitSearchUseCaseMock: GitSearchUseCaseProtocol {
    // MARK: - Private Properties
    private var dataPublisherRepository: PassthroughSubject<[Repository], Error> = PassthroughSubject<[Repository], Error>()
    private var dataPublisherBranches: PassthroughSubject<[Branch], Error> = PassthroughSubject<[Branch], Error>()
    
    // MARK: - GitSearchUseCaseProtocol implementation
    public func searchGitRepositories(_ search: GitSearchRequest) -> AnyPublisher<[Repository], Error> {
        return dataPublisherRepository.eraseToAnyPublisher()
    }
    
    public func getRepositoryBranches(request: RepoBranchRequest) -> AnyPublisher<[Branch], Error> {
        return dataPublisherBranches.eraseToAnyPublisher()
    }
    
    public func sendRepository() {
        dataPublisherRepository.send(FakeGitSearchData.fakeData.items)
    }
    
    public func sendBranches() {
        dataPublisherBranches.send(FakeGitSearchData.fakeData.items[0].branches)
    }
    
    public func sendError() {
        let error = ErrorMock()
        dataPublisherRepository.send(completion: .failure(error))
    }
}
