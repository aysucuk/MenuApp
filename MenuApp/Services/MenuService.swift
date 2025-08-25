//
//  MenuService.swift
//  MenuApp
//
//  Created by Aysu Sadıxova on 25.08.25.
//

import Foundation

class MenuService {
    static func loadMenu(completion: @escaping (Result<Menu, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "menu", withExtension: "json") else {
            completion(.failure(NSError(domain: "MenuService", code: 404, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])))
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let menu = try JSONDecoder().decode(Menu.self, from: data)
            completion(.success(menu))
        } catch {
            completion(.failure(error))
        }
    }
}

