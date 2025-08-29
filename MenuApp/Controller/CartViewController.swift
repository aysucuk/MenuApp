//
//  CartViewController.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 29.08.25.
//

import Foundation

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
        
        // səbət dəyişəndə TableView refresh etsin
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
    

}
