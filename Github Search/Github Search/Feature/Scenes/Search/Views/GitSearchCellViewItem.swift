//
//  GitSearchCellViewItem.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation
import Domain

struct GitSearchCellViewItem {
    // MARK: - Private Properties
    private let id: Int
    
    // MARK: - Public Properties
    let repoName: String
    let repoFullName: String
    let branchCount: String
    let likeCount: String
    let forkCount: String
    
    // MARK: - init Method
    init(repository: Repository) {
        id = repository.id
        repoName = repository.name
        repoFullName = repository.fullName
        branchCount = "\(repository.branches.count)"
        forkCount = "\(repository.forkCount)"
        likeCount = "\(repository.likeCount)"
    }
}

extension GitSearchCellViewItem: Hashable {
    static func == (lhs: GitSearchCellViewItem, rhs: GitSearchCellViewItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
