//
//  CartCell.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 29.08.25.
//

import UIKit

class CartCell: UITableViewCell {
    
    private var cartItem: CartItem?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemOrange
        return label
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("–", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.addTarget(CartCell.self, action: #selector(decreaseTapped), for: .touchUpInside)
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.addTarget(CartCell.self, action: #selector(increaseTapped), for: .touchUpInside)
        return button
    }()
    
    var onIncrease: ((CartItem) -> Void)?
    var onDecrease: ((CartItem) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(totalPriceLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(plusButton)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            countLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 40),

            totalPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            totalPriceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            minusButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -1),
            minusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 10),
            minusButton.heightAnchor.constraint(equalToConstant: 10),

            plusButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 1),
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 10),
            plusButton.heightAnchor.constraint(equalToConstant: 10)
        ])
    }

    @objc private func increaseTapped() {
        guard let item = cartItem else { return }
        onIncrease?(item)
    }

    @objc private func decreaseTapped() {
        guard let item = cartItem else { return }
        onDecrease?(item)
    }

    
    func configure(with item: CartItem) {
        self.cartItem = item
        nameLabel.text = item.product.name
        countLabel.text = "x\(item.quantity)"
        totalPriceLabel.text = "\(item.product.price * Double(item.quantity)) ₼"
    }


}
