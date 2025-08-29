//
//  Cart.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 29.08.25.
//

struct CartItem: Codable {
    let product: Product
    var quantity: Int
    
    var subtotal: Double {
        return Double(quantity) * product.price
    }
}
