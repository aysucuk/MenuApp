//
//  ProductsViewModel.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 26.08.25.
//

import Foundation

protocol ProductsViewModelProtocol: AnyObject {
    var products: [Product] { get }
    var title: String { get }

    func product(at index: Int) -> Product?
    var numberOfProducts: Int { get }
}

class ProductsViewModelImpl: ProductsViewModelProtocol {
    let products: [Product]
    let title: String

    init(products: [Product], title: String) {
        self.products = products
        self.title = title
    }

    var numberOfProducts: Int {
        return products.count
    }

    func product(at index: Int) -> Product? {
        guard products.indices.contains(index) else { return nil }
        return products[index]
    }
}

