//
//  CartCell.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 29.08.25.
//

import UIKit

class CartCell: UITableViewCell {
    
    private var cartItem: CartItem?
    
    private let nameLabel = UILabel()
    private let countLabel = UILabel()
    private let totalPriceLabel = UILabel()
    private let minusButton = UIButton(type: .system)
    private let plusButton = UIButton(type: .system)
    
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
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        countLabel.font = .systemFont(ofSize: 14, weight: .regular)
        countLabel.textAlignment = .center
        totalPriceLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        totalPriceLabel.textColor = .systemOrange
        
        minusButton.setTitle("–", for: .normal)
        minusButton.titleLabel?.font = .systemFont(ofSize: 15)
        minusButton.addTarget(self, action: #selector(decreaseTapped), for: .touchUpInside)

        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = .systemFont(ofSize: 15)
        plusButton.addTarget(self, action: #selector(increaseTapped), for: .touchUpInside)


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
            
            minusButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -5),
            minusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 20),
            minusButton.heightAnchor.constraint(equalToConstant: 20),

            plusButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 5),
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 20),
            plusButton.heightAnchor.constraint(equalToConstant: 20)
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
