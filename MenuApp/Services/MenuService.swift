//
//  MenuService.swift
//  MenuApp
//
//  Created by Aysu Sadıxova on 25.08.25.
//

import Foundation

class MenuService {
    static func loadMenu(completion: @escaping (Result<Menu, Error>) -> Void) {

        if let menu = MenuDataManager.shared.loadMenu() {
            completion(.success(menu))
        } else {
            completion(.failure(NSError(domain: "MenuService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Menu not found"])))
        }
    }
}
