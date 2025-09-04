//
//  CartViewModel.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 01.09.25.
//

import Foundation

protocol CartViewModelProtocol: AnyObject {
    var items: [CartItem] { get }
    var onUpdate: (() -> Void)? { get set }

    func loadCart()
    func addToCart(_ product: Product)
    func removeFromCart(_ product: Product)
}

class CartViewModelImpl: CartViewModelProtocol {
    private(set) var items: [CartItem] = []
    var onUpdate: (() -> Void)?

    func loadCart() {
        items = CartManager.shared.items
        onUpdate?()
    }

    func addToCart(_ product: Product) {
        CartManager.shared.add(product)
        items = CartManager.shared.items
        onUpdate?()
    }

    func removeFromCart(_ product: Product) {
        CartManager.shared.remove(product)
        items = CartManager.shared.items
        onUpdate?()
    }
}
