//
//  CategoriesViewModel.swift
//  MenuApp
//
//  Created by Aysu Sadıxova on 25.08.25.
//

import Foundation

protocol CategoriesViewModelProtocol: AnyObject {
    var categories: [Category] { get }
    var selectedCategoryIndex: Int { get set }

    func loadMenu()
    func numberOfRowsInSelectedCategory() -> Int
    func titleForRow(at index: Int) -> String
    var delegate: CategoriesViewModelDelegate? { get set }
}

protocol CategoriesViewModelDelegate: AnyObject {
    func didLoadMenu()
    func didFailLoadingMenu(error: Error)
}

class CategoriesViewModelImpl: CategoriesViewModelProtocol {
    weak var delegate: CategoriesViewModelDelegate?
    private var menu: Menu?
    var selectedCategoryIndex: Int = 0

    var categories: [Category] {
        menu?.categories ?? []
    }

    func loadMenu() {
        MenuService.loadMenu { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let menu):
                    self?.menu = menu
                    self?.delegate?.didLoadMenu()
                case .failure(let error):
                    self?.delegate?.didFailLoadingMenu(error: error)
                }
            }
        }
    }

    func numberOfRowsInSelectedCategory() -> Int {
        guard categories.indices.contains(selectedCategoryIndex) else { return 0 }
        let category = categories[selectedCategoryIndex]
        return category.subcategories?.count ?? category.products?.count ?? 0
    }


    func titleForRow(at index: Int) -> String {
        let category = categories[selectedCategoryIndex]
        if let sub = category.subcategories?[index] {
            return sub.name
        } else if let product = category.products?[index] {
            return product.name
        } else {
            return ""
        }
    }
}
