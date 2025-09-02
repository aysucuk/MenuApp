//
//  NewProductViewModel.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 02.09.25.
//

import Foundation

protocol NewProductViewModelProtocol: AnyObject {
    var onProductCreated: ((Product) -> Void)? { get set }
    func createProduct(name: String?, description: String?, priceText: String?)
}

class AddProductViewModelImpl: NewProductViewModelProtocol {
    
    var onProductCreated: ((Product) -> Void)?
    
    func createProduct(name: String?, description: String?, priceText: String?) {
        guard
            let name = name, !name.isEmpty,
            let description = description, !description.isEmpty,
            let priceText = priceText, let price = Double(priceText)
        else {
            return
        }
        
        let product = Product(
            id: Int.random(in: 1000...9999),
            name: name,
            description: description,
            price: price,
            imageName: ""
        )
        
        onProductCreated?(product)
    }
}
