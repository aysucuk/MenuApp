//
//  MenuManager.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 03.09.25.
//

import Foundation

class MenuDataManager {
    static let shared = MenuDataManager()
    private init() {}
    
    private let menuKey = "fullMenu"

    func initializeDefaultMenuIfNeeded() {
        if UserDefaults.standard.data(forKey: menuKey) == nil {
            createDefaultMenu()
        }
    }
    
    private func createDefaultMenu() {
        let defaultMenu = Menu(categories: [
           
            Category(id: 1, name: "Yeməklər", subcategories: [
                Subcategory(id: 11, name: "İsti yeməklər", products: [
                    Product(id: 111, name: "Toyuq kababı", description: "Kömürdə bişmiş toyuq şiş", price: 15.50, imageName: "toyuq_kababi", subcategoryId: 11),
                    Product(id: 112, name: "Ət qovurma", description: "Soğanla birlikdə qızardılmış dana əti", price: 20.00, imageName: "et_qovurma", subcategoryId: 11),
                    Product(id: 113, name: "Şah plov", description: "6-8 nəfərlik milli şah plov", price: 85.00, imageName: "sahplov", subcategoryId: 11),
                    Product(id: 114, name: "Dolma", description: "Üzüm yarpağı ilə bükülmüş dolma", price: 12.00, imageName: "dolma", subcategoryId: 11),
                    Product(id: 115, name: "Qovurma", description: "Naxçıvanın milli yeməyi", price: 25.00, imageName: "qovurma", subcategoryId: 11),
                    Product(id: 116, name: "Lazanya", description: "İtalyan mətbəxinin incisi", price: 18.00, imageName: "lazanya", subcategoryId: 11),
                    Product(id: 117, name: "Toyuq sacı", description: "Pomidor və bibərlə bişirilmiş toyuq sacı", price: 28.00, imageName: "toyuq_saci", subcategoryId: 11),
                    Product(id: 118, name: "Dana sacı", description: "Tərəvəzlərlə birlikdə dana sacı", price: 35.50, imageName: "dana_saci", subcategoryId: 11)
                ], subcategories: nil),
                
                Subcategory(id: 12, name: "Salatlar", products: [
                    Product(id: 121, name: "Sezar salatı", description: "Toyuq filesi ilə sezar salatı", price: 18.00, imageName: "sezar", subcategoryId: 12),
                    Product(id: 122, name: "Çoban salatı", description: "Yaşıl otlarla pomidor və xiyar", price: 8.00, imageName: "cobansalati", subcategoryId: 12),
                    Product(id: 123, name: "Badımcan salatı", description: "Turşa şirin sous ilə xırt-xırt salat", price: 10.00, imageName: "badımcan", subcategoryId: 12),
                    Product(id: 124, name: "Mimoza salatı", description: "Üzərinə pendir əlavəsi ilə", price: 10.00, imageName: "mimoza", subcategoryId: 12),
                    Product(id: 125, name: "Çuğundur salatı", description: "Sarımsaq və qozlu sous ilə", price: 10.00, imageName: "cugundursalati", subcategoryId: 12),
                    Product(id: 126, name: "Paytaxt salatı", description: "Milli mətbəx", price: 10.00, imageName: "stalicni", subcategoryId: 12)
                ], subcategories: nil),
                
                Subcategory(id: 13, name: "Qəlyanaltılar", products: [
                    Product(id: 131, name: "Pendir assortisi", description: "Azərbaycan pendirlərindən qarışıq", price: 35.00, imageName: "pendir", subcategoryId: 13),
                    Product(id: 132, name: "Kükü", description: "Yaşıl otlarla bişmiş yumurta yeməyi", price: 8.00, imageName: "kuku", subcategoryId: 13),
                    Product(id: 133, name: "Badımcan salatı", description: "Turşa şirin sous ilə xırt-xırt salat", price: 12.00, imageName: "badımcan", subcategoryId: 13)
                ], subcategories: nil),
                
                Subcategory(id: 14, name: "Şorbalar", products: [
                    Product(id: 141, name: "Düşbərə", description: "Ətli xəmir xörəyi", price: 9.50, imageName: "dushbere", subcategoryId: 14),
                    Product(id: 142, name: "Mercimek şorbası", description: "Qırmızı mərci ilə hazırlanmış şorba", price: 8.00, imageName: "mercimek", subcategoryId: 14),
                    Product(id: 143, name: "Dovğa", description: "Milli mətbəx", price: 8.00, imageName: "dovga", subcategoryId: 14)
                ], subcategories: nil)
            ], products: nil),
            
          
            Category(id: 2, name: "İçkilər", subcategories: [
                Subcategory(id: 21, name: "Alkoqolsuz içkilər", products: [
                    Product(id: 211, name: "Coca Cola", description: "Soyuq qazlı içki", price: 4.00, imageName: "cocacola", subcategoryId: 21),
                    Product(id: 212, name: "Fanta", description: "Portağal dadlı qazlı içki", price: 4.00, imageName: "fanta", subcategoryId: 21),
                    Product(id: 213, name: "Su", description: "Qazsız Sirab", price: 2.00, imageName: "sirab", subcategoryId: 21)
                ], subcategories: nil),
                
                Subcategory(id: 22, name: "Alkoqollu içkilər", products: [
                    Product(id: 221, name: "Jack Daniel's", description: "Amerikan viskisi", price: 85.00, imageName: "jack_daniels", subcategoryId: 22),
                    Product(id: 222, name: "Chivas Regal", description: "Şotland viskisi", price: 42.00, imageName: "chivas", subcategoryId: 22),
                    Product(id: 223, name: "Finlandia", description: "Fin arağı", price: 28.00, imageName: "finlandia", subcategoryId: 22),
                    Product(id: 224, name: "Absolut", description: "İsveç arağı", price: 30.00, imageName: "absolut", subcategoryId: 22),
                    Product(id: 225, name: "Qırmızı şərab", description: "Cabernet Sauvignon", price: 25.00, imageName: "red_wine", subcategoryId: 22),
                    Product(id: 226, name: "Ağ şərab", description: "Chardonnay", price: 25.00, imageName: "white_wine", subcategoryId: 22)
                ], subcategories: nil)
            ], products: nil),
            
         
            Category(id: 3, name: "Desertlər", subcategories: [
                Subcategory(id: 31, name: "Südlü şirniyyatlar", products: [
                    Product(id: 311, name: "Tiramisu", description: "İtalyan deserti", price: 10.00, imageName: "tiramisu", subcategoryId: 31),
                    Product(id: 312, name: "Pudinq", description: "İtalyan deserti", price: 8.00, imageName: "pudinq", subcategoryId: 31)
                ], subcategories: nil),
                
                Subcategory(id: 32, name: "Şərbətli şirniyyatlar", products: [
                    Product(id: 321, name: "Şəkərbura", description: "Qozlu şirniyyat", price: 5.00, imageName: "sekerbura", subcategoryId: 32),
                    Product(id: 322, name: "Paxlava", description: "Milli şirniyyat", price: 6.00, imageName: "paxlava", subcategoryId: 32)
                ], subcategories: nil)
            ], products: nil),
            
  
            Category(id: 4, name: "Digər", subcategories: [
                Subcategory(id: 41, name: "Sous", products: [
                    Product(id: 411, name: "Pendir sousu", description: "Çedar pendiri", price: 2.50, imageName: "pendirsousu", subcategoryId: 41),
                    Product(id: 412, name: "Barbekü sousu", description: "Şirin barbekü sousu", price: 1.50, imageName: "barbekusousu", subcategoryId: 41)
                ], subcategories: nil),
                
                Subcategory(id: 42, name: "Əlavələr", products: [
                    Product(id: 421, name: "Çörək", description: "Təndirdə bişmiş çörək", price: 1.50, imageName: "tendircoreyi", subcategoryId: 42),
                    Product(id: 422, name: "Lavaş", description: "Sac lavaşı", price: 1.50, imageName: "lavas", subcategoryId: 42)
                ], subcategories: nil)
            ], products: nil)
        ])
        
        saveMenu(defaultMenu)
    }
    

    func loadMenu() -> Menu? {
        guard let data = UserDefaults.standard.data(forKey: menuKey),
              let menu = try? JSONDecoder().decode(Menu.self, from: data) else {
            return nil
        }
        return menu
    }

    private func saveMenu(_ menu: Menu) {
        guard let data = try? JSONEncoder().encode(menu) else { return }
        UserDefaults.standard.set(data, forKey: menuKey)
    }

    func addProduct(_ product: Product, to subcategoryId: Int) {
        guard var menu = loadMenu() else { return }
      
        if addProductToSubcategory(&menu.categories, product: product, subcategoryId: subcategoryId) {
            saveMenu(menu)
        }
    }
    
    private func addProductToSubcategory(_ categories: inout [Category], product: Product, subcategoryId: Int) -> Bool {
        for categoryIndex in 0..<categories.count {
            if var subcategories = categories[categoryIndex].subcategories {
                if addProductToSubcategoryRecursive(&subcategories, product: product, subcategoryId: subcategoryId) {
                    categories[categoryIndex].subcategories = subcategories
                    return true
                }
            }
        }
        return false
    }
    
    private func addProductToSubcategoryRecursive(_ subcategories: inout [Subcategory], product: Product, subcategoryId: Int) -> Bool {
        for subIndex in 0..<subcategories.count {
            if subcategories[subIndex].id == subcategoryId {
                if subcategories[subIndex].products == nil {
                    subcategories[subIndex].products = []
                }
                subcategories[subIndex].products?.append(product)
                return true
            }
            
            if var nestedSubs = subcategories[subIndex].subcategories {
                if addProductToSubcategoryRecursive(&nestedSubs, product: product, subcategoryId: subcategoryId) {
                    subcategories[subIndex].subcategories = nestedSubs
                    return true
                }
            }
        }
        return false
    }

    func getProductsForSubcategory(subcategoryId: Int) -> [Product] {
        guard let menu = loadMenu() else { return [] }
        return findProductsInSubcategory(subcategoryId: subcategoryId, categories: menu.categories)
    }
    
    private func findProductsInSubcategory(subcategoryId: Int, categories: [Category]) -> [Product] {
        for category in categories {
            if let subcategories = category.subcategories {
                if let products = findProductsRecursive(subcategoryId: subcategoryId, subcategories: subcategories) {
                    return products
                }
            }
        }
        return []
    }
    
    private func findProductsRecursive(subcategoryId: Int, subcategories: [Subcategory]) -> [Product]? {
        for subcategory in subcategories {
            if subcategory.id == subcategoryId {
                return subcategory.products ?? []
            }
            if let nested = subcategory.subcategories {
                if let found = findProductsRecursive(subcategoryId: subcategoryId, subcategories: nested) {
                    return found
                }
            }
        }
        return nil
    }
}
