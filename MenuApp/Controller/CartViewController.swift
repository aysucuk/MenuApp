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
        
        self.reloadData(viewModel.items)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = super.tableView(tableView, cellForRowAt: indexPath) as? CartCell else {
            return UITableViewCell()
        }

        let cartItem = viewModel.items[indexPath.row]

        cell.onIncrease = { [weak self] item in
            guard let self = self else { return }
            self.viewModel.addToCart(item.product)
        }

        cell.onDecrease = { [weak self] item in
            guard let self = self else { return }
            self.viewModel.removeFromCart(item.product)
        }

        cell.configure(with: cartItem)

        return cell
    }
}
