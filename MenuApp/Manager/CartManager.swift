//
//  CartManager.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 27.08.25.
//

import Foundation

class CartManager {
    static let shared = CartManager()
    private init() {}
    
    private(set) var items: [CartItem] = []
    var onUpdate: (() -> Void)?
    
    func add(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
        onUpdate?()
    }
    
    func remove(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
            onUpdate?()
        }
    }
    
    func clear() {
        items.removeAll()
        onUpdate?()
    }
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.subtotal }
    }
}
