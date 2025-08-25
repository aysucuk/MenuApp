//
//  MenuModel.swift
//  MenuApp
//
//  Created by Aysu Sadıxova on 25.08.25.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageURL: String
}

// MARK: - Subcategory
struct Subcategory: Codable {
    let id: Int
    let name: String
    let products: [Product]?
    let subcategories: [Subcategory]?  // alkoqollu içkilər kimi nested varsa
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    let subcategories: [Subcategory]?
    let products: [Product]?
}

// MARK: - Root JSON
struct Menu: Codable {
    let categories: [Category]
}

