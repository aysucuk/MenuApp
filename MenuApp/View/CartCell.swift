//
//  CartCell.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 29.08.25.
//

import UIKit

class CartCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let countLabel = UILabel()
    private let totalPriceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        countLabel.font = .systemFont(ofSize: 14, weight: .regular)
        countLabel.textAlignment = .center
        totalPriceLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        totalPriceLabel.textColor = .systemOrange

        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(totalPriceLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            countLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 40),

            totalPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            totalPriceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }


    func configure(with product: CartItem) {
        nameLabel.text = product.product.name
        countLabel.text = "x\(product.quantity)"   // quantity əlavə edəcəyik
        totalPriceLabel.text = "\(product.product.price * Double(product.quantity)) ₼"
    }
}
