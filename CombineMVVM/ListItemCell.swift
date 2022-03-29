//
//  ListItemCell.swift
//  CombineMVVM
//
//  Created by Ufuk Canlı on 29.03.2022.
//

import UIKit

final class ListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: self)

    private lazy var nameLabel = UILabel()
    lazy var showButton = UIButton()
    
    var viewModel: ListItemCellViewModel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateCell(with viewModel: ListItemCellViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.animalName
    }
}


// MARK: - Configure UI
private extension ListItemCell {
    
    func configureCell() {
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
