//
//  GitSearchRepositoriesViewController.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit
import Combine

final class GitSearchRepositoriesViewController: UIViewController {
    // MARK: - Private Properties
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    private lazy var dataSource = createDataSource()
    private let viewModel: GitSearchRepoViewModel
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    private lazy var indicator = createActivityIndicator()
    
    // MARK: - Init
    init?(coder: NSCoder, viewModel: GitSearchRepoViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("viewModel(GitSearchRepoViewModel) must provided while initialisation")
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
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: indicator)]
    }
    
    private func bind() {
        tableView.dataSource = dataSource
        viewModel.stateDidUpdate.sink(receiveValue: { [weak self] state in
            guard let self = self else { return }
            
            self.renderViewModelState(state)
        }).store(in: &cancellable)
        bindSearchField()
    }
    
    private func bindSearchField() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self.searchBar.searchTextField)
        publisher .map { ($0.object as? UISearchTextField)?.text }
        .debounce(for: .milliseconds(viewModel.searchWaitMilliSecond), scheduler: RunLoop.main)
        .sink(receiveValue: { [weak self] (value) in
            guard let self = self else { return }
            self.viewModel.searchTextChange(searchText: value ?? "")
        })
        .store(in: &cancellable)
    }
    
    private func renderViewModelState(_ state: GitSearchViewModelState) {
        switch state {
        case .error(let errorMessage):
            updateTable(with: [], animate: false)
            showAlert(errorMessage)
        case .showRepositories(let repositories):
            updateTable(with: repositories, animate: false)
        case .showIndicator(let isShown):
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.indicator.isHidden = !isShown
            }
        }
    }
    
    func createActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        indicator.isHidden = true
        return indicator
    }
}

// MARK: - Extension for Tableview datasource
fileprivate extension GitSearchRepositoriesViewController {
    enum Section: CaseIterable {
        case Repositories
    }
    
    private func createDataSource() -> UITableViewDiffableDataSource<Section, GitSearchCellViewItem> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, repoCellViewModel in
                let cell: GitSearchRepoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configure(with: repoCellViewModel)
                return cell
            })
    }
    
    private func updateTable(with repositories: [GitSearchCellViewItem], animate: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Section, GitSearchCellViewItem>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(repositories, toSection: .Repositories)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}

// MARK: - Extension for UITableViewDelegate
extension GitSearchRepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelet(index: indexPath.row)
    }
}

// MARK: - Extension for UISearchBarDelegate
extension GitSearchRepositoriesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
