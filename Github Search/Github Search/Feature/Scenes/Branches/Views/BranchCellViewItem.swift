//
//  BranchCellViewItem.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation
import Domain

struct BranchCellViewItem {
    // MARK: - Private Properties
    private let id: UUID
    
    // MARK: - Public Properties
    let branchName: String
    
    // MARK: - init Method
    init(branch: Branch) {
        id = UUID()
        branchName = branch.name
    }
}

extension BranchCellViewItem: Hashable {
    static func == (lhs: BranchCellViewItem, rhs: BranchCellViewItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
