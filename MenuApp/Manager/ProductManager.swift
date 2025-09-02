//
//  ProductManager.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 02.09.25.
//

class ProductManager {
    static let shared = ProductManager()
    private init() {}
    
    private(set) var products: [Product] = []
    
    func add(_ product: Product) {
        products.append(product)
    }
}
