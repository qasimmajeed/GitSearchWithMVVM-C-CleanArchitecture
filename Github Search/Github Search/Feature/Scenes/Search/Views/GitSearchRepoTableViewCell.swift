//
//  GitSearchRepoTableViewCell.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit

final class GitSearchRepoTableViewCell: UITableViewCell {
    // MARK: - private properties
    @IBOutlet private weak var repoNameLabel: UILabel!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var branchCountLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    @IBOutlet private weak var forkCountLabel: UILabel!
    
    // MARK: - Public methods
    /// Use to fill the view with the GitSearchCellViewItem.
    public func configure(with viewItem: GitSearchCellViewItem) {
        repoNameLabel.text = viewItem.repoName
        fullNameLabel.text = viewItem.repoFullName
        branchCountLabel.text = viewItem.branchCount
        likesCountLabel.text = viewItem.likeCount
        forkCountLabel.text = viewItem.forkCount
    }
}
