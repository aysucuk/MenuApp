//
//  CartViewController.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 29.08.25.
//

import UIKit

class CartController: UIViewController {
    
    private let tableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Int, CartItem>!
    
    private lazy var viewModel: CartViewModelProtocol = {
        let vm = CartViewModelImpl()
        vm.onUpdate = { [weak self] in
            self?.updateSnapshot()
        }
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Səbət"
        setupTableView()
        setupDataSource()
        viewModel.loadCart()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(CartCell.self, forCellReuseIdentifier: "CartCell")
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, CartItem>(tableView: tableView) { tableView, indexPath, cartItem in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else {
                return UITableViewCell()
            }
            cell.configure(with: cartItem)
            cell.delegate = self
            return cell
        }
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CartItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension CartController: CartCellDelegate {
    func cartCellDidIncrease(_ cell: CartCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = viewModel.items[indexPath.row]
        viewModel.addToCart(item.product)
    }
    
    func cartCellDidDecrease(_ cell: CartCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = viewModel.items[indexPath.row]
        viewModel.removeFromCart(item.product)
    }
}
