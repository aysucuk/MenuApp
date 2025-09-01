//
//  CartViewController.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 29.08.25.
//

import Foundation
import UIKit

class CartController: TableViewController<CartItem, CartCell> {
    
    init() {
        super.init(
            items: CartManager.shared.items,
            configureCell: { cell, cartItem in
                cell.configure(with: cartItem)
            },
            didSelectItem: { product in
                print("Tapped on \(product.product.name)")
            },
            title: "Səbət"
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateCart),
            name: .cartUpdated,
            object: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func updateCart() {
        self.reloadData(CartManager.shared.items)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = super.tableView(tableView, cellForRowAt: indexPath) as? CartCell else {
            return UITableViewCell()
        }

        let cartItem = CartManager.shared.items[indexPath.row]

        cell.onIncrease = { [weak self] in
            guard let cartItem = cell.cartItem else { return }
            CartManager.shared.add(cartItem.product)
            self?.reloadData(CartManager.shared.items)
        }

        cell.onDecrease = { [weak self] in
            guard let cartItem = cell.cartItem else { return }
            CartManager.shared.remove(cartItem.product)
            self?.reloadData(CartManager.shared.items)
        }


        return cell
    }

    

}
