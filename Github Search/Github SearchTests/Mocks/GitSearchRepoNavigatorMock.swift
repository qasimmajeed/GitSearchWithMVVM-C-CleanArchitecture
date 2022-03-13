//
//  GitSearchRepoNavigatorMock.swift
//  Github SearchTests
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation
import Domain

@testable import Github_Search

final class GitSearchRepoNavigatorMock: GitSearchRepoNavigator {
    // MARK: - Private Properties
    private(set) var showRepoBranches = false
    
    // MARK: - GitSearchRepoNavigator Implementation
    func showRepositoryBranches(repository: Repository) {
        showRepoBranches = true
    }
}
