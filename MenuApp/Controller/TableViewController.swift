//
//  TableViewController.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 26.08.25.
//

import UIKit

class TableViewController<Item: Hashable, Cell: UITableViewCell>: UIViewController, UITableViewDelegate {

    var items: [Item]
    internal let tableView = UITableView()
    private let configureCell: (Cell, Item) -> Void
    private let didSelectItem: ((Item) -> Void)?
    private let cartButtonView = CartButton()
    internal let showCartButton: Bool
    var subcategoryId: Int?
    
    private var dataSource: UITableViewDiffableDataSource<Int, Item>!

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

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setupDataSource()
        
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
        }
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        CartManager.shared.onUpdate = { [weak self] in
            self?.updateCartBadge()
        }
        
        if Item.self == Product.self {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewProduct))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Item.self == Product.self {
            if let subId = self.subcategoryId {
               
                let products = MenuDataManager.shared.getProductsForSubcategory(subcategoryId: subId)
                reloadData(products as! [Item])
            } else {
                reloadData(items)
            }
        } else {
            reloadData(items)
        }
        
        updateCartBadge()
    }


    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, Item>(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? Cell else {
                return UITableViewCell()
            }
            self.configureCell(cell, item)
            if let productCell = cell as? ProductCell {
                productCell.delegate = self
            }
            return cell
        }
    }
    
    func reloadData(_ items: [Item]) {
        self.items = items
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
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
        guard showCartButton else {
            cartButtonView.isHidden = true
            return
        }
        let count = CartManager.shared.items.reduce(0) { $0 + $1.quantity }
        cartButtonView.updateBadge(count)
    }
    
    @objc private func addNewProduct() {
          guard let subcategoryId = self.subcategoryId else { return }
          
          let addVC = NewProductViewController()
          addVC.subcategoryId = subcategoryId
          
          addVC.onSave = { [weak self] newProduct in
              guard let self = self else { return }
              
              MenuDataManager.shared.addProduct(newProduct, to: subcategoryId)
              
              let products = MenuDataManager.shared.getProductsForSubcategory(subcategoryId: subcategoryId)
              self.reloadData(products as! [Item])
          }
          
          navigationController?.pushViewController(addVC, animated: true)
      }


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        didSelectItem?(item)
    }
    
    private func findSubcategory(by id: Int, in categories: [Category]) -> Subcategory? {
        for category in categories {
            if let subs = category.subcategories {
                if let found = findSubcategoryRecursive(subId: id, subcategories: subs) {
                    return found
                }
            }
        }
        return nil
    }

    private func findSubcategoryRecursive(subId: Int, subcategories: [Subcategory]) -> Subcategory? {
        for sub in subcategories {
            if sub.id == subId {
                return sub
            }
            if let nestedSubs = sub.subcategories {
                if let found = findSubcategoryRecursive(subId: subId, subcategories: nestedSubs) {
                    return found
                }
            }
        }
        return nil
    }
    
    private func saveProductsToUserDefaults(_ products: [Product]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(products) {
            UserDefaults.standard.set(data, forKey: "products")
        }
    }

    private func loadProductsFromUserDefaults() -> [Product] {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "products"),
           let savedProducts = try? decoder.decode([Product].self, from: data) {
            return savedProducts
        }
        return []
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
