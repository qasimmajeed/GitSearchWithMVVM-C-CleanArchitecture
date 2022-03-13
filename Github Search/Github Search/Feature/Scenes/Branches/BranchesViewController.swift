//
//  BranchesViewController.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit

final class BranchesViewController: UIViewController {
    // MARK: - Private Properties
    @IBOutlet private weak var tableView: UITableView!
    private lazy var dataSource = createDataSource()
    private let viewModel: BranchesViewModel
    
    // MARK: - init
    init?(coder: NSCoder, viewModel: BranchesViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("viewModel(BranchesViewModel) must provided while initialization")
    }
    
    // MARK: - Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        self.title = viewModel.title
    }
    
    private func bind() {
        tableView.dataSource = dataSource
        updateTable(with: viewModel.branchesViewItem)
    }
}

// MARK: - Extension for Tableview datasource
fileprivate extension BranchesViewController {
    enum Section: CaseIterable {
        case Branches
    }
    
    private func createDataSource() -> UITableViewDiffableDataSource<Section, BranchCellViewItem> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, branchCellViewItem in
                let cell: BranchTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configure(with: branchCellViewItem)
                return cell
            })
    }
    
    private func updateTable(with branches: [BranchCellViewItem]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Section, BranchCellViewItem>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(branches, toSection: .Branches)
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}

// MARK: - Extension for UITableViewDelegate
extension BranchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
