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
    
    private var cancellables: Set<AnyCancellable> = []

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
    }
}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListItemCell.reuseIdentifier, for: indexPath) as! ListItemCell
        cell.populateCell(with: ListItemCellViewModel(animal: viewModel.animals[indexPath.row]))
        cell.viewModel.actionPublisher.sink { [weak self] animal in
            guard let self = self else { return }
            AlertManager.showAlert(with: animal.emoji, in: self)
        }
        .store(in: &cancellables)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ListItemCell {
            cell.viewModel.sendEmoji()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - Actions
extension ListViewController {
    
    @objc func didTapNetworkButton(_ button: UIBarButtonItem) {
        viewModel.fetch()
    }
}


// MARK: - Helpers
private extension ListViewController {
    
    func bindViewModel() {
//        viewModel.$animals
//            .sink { animals in
//                print(animals)
//            }
//            .store(in: &cancellables)
        viewModel.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}


// MARK: - Configure UI
private extension ListViewController {
    
    func configureNavigationBar() {
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapNetworkButton)
        )
        navigationController?.navigationBar.prefersLargeTitles = true
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
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 52.0
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
