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
    
    private(set) var items: [Product] = []
    
    func add(_ product: Product) {
        items.append(product)
    }
    
    func remove(_ product: Product) {
        if let index = items.firstIndex(where: { $0.id == product.id }) {
            items.remove(at: index)
        }
    }
    
    func clear() {
        items.removeAll()
    }
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
}

extension Notification.Name {
    static let cartUpdated = Notification.Name("cartUpdated")
}

