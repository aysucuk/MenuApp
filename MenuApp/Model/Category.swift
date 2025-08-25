//
//  Category.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 25.08.25.
//

import Foundation

struct Category {
    let id: UUID = UUID()
    let name: String
    var children: [Category]?
}

struct CategoriesData {
    static let categories: [Category] = [
        Category(name: "Yeməklər", children: [
            Category(name: "İsti yeməklər"),
            Category(name: "Sac yeməkləri"),
            Category(name: "Qəlyanaltılar"),
            Category(name: "Şorabalar")
        ]),
        Category(name: "İçkilər", children: [
            Category(name: "Alkoqolsuz içkilər"),
            Category(name: "Alkoqollu içkilər", children: [
                Category(name: "Viskilər"),
                Category(name: "Araqlar"),
                Category(name: "Şərablar")
            ])
        ]),
        Category(name: "Desertlər"),
        Category(name: "Digər")
    ]
}
