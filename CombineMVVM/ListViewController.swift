//
//  ListViewController.swift
//  CombineMVVM
//
//  Created by Ufuk Canlı on 29.03.2022.
//

import UIKit
import Combine

final class ListViewController: UIViewController {
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private lazy var loadingView = UIActivityIndicatorView(style: .large)
    
    private let viewModel: ListViewModel!
    
    init(viewModel: ListViewModel = ListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        bindViewModel()
        configureNavigationBar()
        configureTableView()
        configureLoadingView()
    }
}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListItemCell.reuseIdentifier, for: indexPath) as! ListItemCell
        cell.populateCell(with: ListItemCellViewModel(comment: viewModel.comments[indexPath.row]))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - Actions
extension ListViewController {
    
    @objc func didTapRefresh(_ button: UIBarButtonItem) {
        debugPrint(#function)
    }
}


// MARK: - Helpers
private extension ListViewController {
    
    func bindViewModel() {
        debugPrint(#function)
    }
}


// MARK: - Configure UI
private extension ListViewController {
    
    func configureNavigationBar() {
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(didTapRefresh)
        )
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureLoadingView() {
        view.addSubview(loadingView)
        
        loadingView.isHidden = true
//        loadingView.startAnimating()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            ListItemCell.self,
            forCellReuseIdentifier: ListItemCell.reuseIdentifier
        )
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 52.0
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
