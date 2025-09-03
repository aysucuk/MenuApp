//
//  Menu.swift
//  MenuApp
//
//  Created by Aysu Sadıxova on 25.08.25.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageName: String
    let subcategoryId: Int
}

struct Subcategory: Codable {
    let id: Int
    let name: String
    var products: [Product]?
    var subcategories: [Subcategory]?
}

struct Category: Codable {
    let id: Int
    let name: String
    var subcategories: [Subcategory]?
    var products: [Product]?
}

struct Menu: Codable {
    var categories: [Category]
}

extension Product: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}

extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
}

extension Subcategory: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Subcategory, rhs: Subcategory) -> Bool {
        lhs.id == rhs.id
    }
}
