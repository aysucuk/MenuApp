//
//  TableViewController.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 26.08.25.
//

import UIKit

class TableViewController<Item, Cell: UITableViewCell>: UIViewController, UITableViewDataSource, UITableViewDelegate {

    internal let tableView = UITableView()
    var items: [Item]
    private let configureCell: (Cell, Item) -> Void
    private let didSelectItem: ((Item) -> Void)?
    
    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        return button
    }()
    
    private let cartBadge: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemRed
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.isHidden = true
        return label
    }()

    init(items: [Item],
         configureCell: @escaping (Cell, Item) -> Void,
         didSelectItem: ((Item) -> Void)? = nil,
         title: String? = nil) {
        self.items = items
        self.configureCell = configureCell
        self.didSelectItem = didSelectItem
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        CartManager.shared.onUpdate = { [weak self] in
            self?.updateCartBadge()
        }

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        cartButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
        view.addSubview(cartButton)
        view.addSubview(cartBadge)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        cartBadge.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            cartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            cartButton.widthAnchor.constraint(equalToConstant: 60),
            cartButton.heightAnchor.constraint(equalToConstant: 60),
            
            cartBadge.topAnchor.constraint(equalTo: cartButton.topAnchor, constant: -5),
            cartBadge.trailingAnchor.constraint(equalTo: cartButton.trailingAnchor, constant: 5),
            cartBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            cartBadge.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        configureCell(cell, item)
        
        if let productCell = cell as? ProductCell, let product = item as? Product {
            productCell.onAddToCart = {
                CartManager.shared.add(product)
                self.updateCartBadge()
            }
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelectItem?(item)
    }
    
    func reloadData(_ items: [Item]) {
        self.items = items
        tableView.reloadData()
    }
    
    @objc private func openCart() {
        let items = CartManager.shared.items
        let cartVC = TableViewController<CartItem, CartCell>(
            items: items,
            configureCell: { cell, product in
                cell.configure(with: product)
            },
            title: "Səbət"
        )
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @objc private func updateCartBadge() {
        let count = CartManager.shared.items.reduce(0) { $0 + $1.quantity }
        cartBadge.text = "\(count)"
        cartBadge.isHidden = count == 0
    }
    
}

