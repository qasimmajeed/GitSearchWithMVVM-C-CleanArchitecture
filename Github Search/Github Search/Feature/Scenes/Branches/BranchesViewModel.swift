//
//  BranchesViewModel.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation
import Domain

final class BranchesViewModel {
    // MARK: - Private Properties
    private let repository: Repository
    
    // MARK: - Public Properties
    public var branchesViewItem: [BranchCellViewItem] = [BranchCellViewItem]()
    public let title: String
    
    // MARK: - init
    init(repository: Repository) {
        self.repository = repository
        self.branchesViewItem = self.repository.branches.map { BranchCellViewItem(branch: $0) }
        self.title = repository.name
    }
}
