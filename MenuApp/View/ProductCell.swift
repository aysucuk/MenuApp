//
//  ProductCell.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 26.08.25.
//

import UIKit

class ProductCell: UITableViewCell {

    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    private let productImageView = UIImageView()
    private let addToCartButton = UIButton(type: .system)
    
    var onAddToCart: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 8

        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 2
        
        priceLabel.font = .systemFont(ofSize: 14, weight: .regular)
        priceLabel.textColor = .darkGray
        
        addToCartButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addToCartButton.tintColor = .systemOrange
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)

        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToCartButton)

        productImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),

            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: -50),


            priceLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            addToCartButton.heightAnchor.constraint(equalToConstant: 30),
            addToCartButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configure(with product: Product) {
        nameLabel.text = product.name
        descriptionLabel.text = product.description
        priceLabel.text = "\(product.price)₼"
        productImageView.image = UIImage(named: product.imageName)
    }

    @objc private func addToCartTapped() {
        onAddToCart?()
    }
    
}
