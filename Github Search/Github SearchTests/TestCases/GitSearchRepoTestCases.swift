//
//  GitSearchRepoTestCases.swift
//  Github SearchTests
//
//  Created by Qasim Majeed on 27.02.22.
//

import XCTest
import Combine
@testable import Github_Search

final class GitSearchRepoViewModelTestCase: XCTestCase {
    // MARK: - Private Properties
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Test Cases
    func testViewModelShouldHaveValidTitle() {
        // Given
        let viewModel = makeTestViewModel()
        let expectedTitle = "Search Repositories"
        
        // Then
        XCTAssertEqual(expectedTitle, viewModel.title)
    }
    
    func testDoesNotOpenRepoBranches() {
        // Given
        let navigator = GitSearchRepoNavigatorMock()
        let viewModel = makeTestViewModel(navigator: navigator)
        // When
        viewModel.didSelet(index: 0)
        
        // Then
        XCTAssertFalse(navigator.showRepoBranches)
    }
    
    func testNoSearchString() {
        // Given
        let searchString = ""
        let viewModel = makeTestViewModel()
        // When
        viewModel.searchTextChange(searchText: "")
        
        // Then
        XCTAssertEqual(searchString.count, 0)
    }
    
    func testViewDidChangeTextForSuccessWhileFetch() {
        // Given
        var isSuccess = false
        let mockUseCase = GitSearchUseCaseMock()
        let navigator = GitSearchRepoNavigatorMock()
        
        let viewModel = makeTestViewModel(useCase: mockUseCase, navigator: navigator)
        mockUseCase.sendRepository()
        
        viewModel.stateDidUpdate.sink { state in
            guard case .showRepositories = state else {return}
            isSuccess = true
        }.store(in: &cancellable)
        
        // When
        viewModel.searchTextChange(searchText: "swift")
        
        // Then
        XCTAssertTrue(isSuccess)
    }
    
    func testViewDidChangeTextForErrorWhileFetch() {
        // Given
        var errorOccur = false
        let mockUseCase = GitSearchUseCaseMock()
        let navigator = GitSearchRepoNavigatorMock()
        
        let viewModel = makeTestViewModel(useCase: mockUseCase, navigator: navigator)
        mockUseCase.sendError()
        
        viewModel.stateDidUpdate.sink { state in
            guard case .error = state else {return}
            errorOccur = true
        }.store(in: &cancellable)
        
        // When
        viewModel.searchTextChange(searchText: "swift")
        
        // Then
        XCTAssertTrue(errorOccur)
    }
}

extension GitSearchRepoViewModelTestCase {
    func makeTestViewModel(useCase: GitSearchUseCaseMock =  GitSearchUseCaseMock(),
                           navigator: GitSearchRepoNavigatorMock = GitSearchRepoNavigatorMock()) -> GitSearchRepoViewModel {
        return  GitSearchRepoViewModel(useCase: useCase, navigator: navigator)
    }
}
