//
//  Cart.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 29.08.25.
//

struct CartItem: Codable, Hashable {
    let product: Product
    var quantity: Int
    
    var subtotal: Double {
        return Double(quantity) * product.price
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(product.id)
    }

    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        lhs.product.id == rhs.product.id
    }
}
