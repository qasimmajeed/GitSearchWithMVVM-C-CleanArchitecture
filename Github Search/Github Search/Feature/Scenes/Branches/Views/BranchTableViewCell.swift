//
//  BranchTableViewCell.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit

final class BranchTableViewCell: UITableViewCell {
    // MARK: - private properties
    @IBOutlet private weak var branchNameLabel: UILabel!
    
    // MARK: - Public methods
    /// Use to fill the view with the BranchCellViewItem.
    public func configure(with viewItem: BranchCellViewItem) {
        branchNameLabel.text = viewItem.branchName
    }
}
