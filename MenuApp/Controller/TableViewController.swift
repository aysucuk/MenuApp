//
//  TableViewController.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 26.08.25.
//

import UIKit

class TableViewController<Item, Cell: UITableViewCell>: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var items: [Item]
    internal let tableView = UITableView()
    private let configureCell: (Cell, Item) -> Void
    private let didSelectItem: ((Item) -> Void)?
    private let cartButtonView = CartButton()
    internal let showCartButton: Bool

    init(items: [Item],
         configureCell: @escaping (Cell, Item) -> Void,
         didSelectItem: ((Item) -> Void)? = nil,
         title: String? = nil,
         showCartButton: Bool = true) {
        self.items = items
        self.configureCell = configureCell
        self.didSelectItem = didSelectItem
        self.showCartButton = showCartButton
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground

            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
            tableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableView)
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            if showCartButton {
                cartButtonView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(cartButtonView)
                view.bringSubviewToFront(cartButtonView)
                NSLayoutConstraint.activate([
                    cartButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
                    cartButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                    cartButtonView.widthAnchor.constraint(equalToConstant: 60),
                    cartButtonView.heightAnchor.constraint(equalToConstant: 60)
                ])
                cartButtonView.onTap = { [weak self] in
                    self?.openCart()
                }
                updateCartBadge()
            }

            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
            
            CartManager.shared.onUpdate = { [weak self] in
                self?.updateCartBadge()
            }
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
        
        if let productCell = cell as? ProductCell {
            productCell.delegate = self
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
            title: "Səbət",
            showCartButton: false
        )
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @objc private func updateCartBadge() {
        if !showCartButton {
            cartButtonView.isHidden = true
            return
        }
        let count = CartManager.shared.items.reduce(0) { $0 + $1.quantity }
        cartButtonView.updateBadge(count)
    }
    
}

extension TableViewController: ProductCellDelegate {
    func productCellDidTapAddToCart(_ cell: ProductCell) {
        if let indexPath = tableView.indexPath(for: cell),
           let product = items[indexPath.row] as? Product {
            CartManager.shared.add(product)
            updateCartBadge()
        }
    }
}
