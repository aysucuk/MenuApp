//
//  CartViewController.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 29.08.25.
//

import UIKit

class CartController: TableViewController<CartItem, CartCell> {

    private lazy var viewModel: CartViewModelProtocol = {
        let vm = CartViewModelImpl()
        vm.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.reloadData(vm.items)
        }
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Səbət"
        viewModel.loadCart()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = super.tableView(tableView, cellForRowAt: indexPath) as? CartCell else {
            return UITableViewCell()
        }

        cell.delegate = self

        let cartItem = viewModel.items[indexPath.row]
        cell.configure(with: cartItem)

        return cell
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
