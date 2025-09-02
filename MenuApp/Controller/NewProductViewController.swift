//
//  NewProductViewController.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 02.09.25.
//

import UIKit

class AddProductViewController: UIViewController {
    
    var onSave: ((Product) -> Void)?
    
    private let nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Ad"
        return field
    }()
    
    private let descriptionField: UITextField = {
        let field = UITextField()
        field.placeholder = "Təsvir"
        return field
    }()
    
    private let priceField: UITextField = {
        let field = UITextField()
        field.placeholder = "Qiymət"
        field.keyboardType = .decimalPad
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Yeni Yemek"
        
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped))
    }
    
    private func setupUI() {
        
        let stack = UIStackView(arrangedSubviews: [nameField, descriptionField, priceField])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func saveTapped() {
        guard
            let name = nameField.text, !name.isEmpty,
            let description = descriptionField.text, !description.isEmpty,
            let priceText = priceField.text, let price = Double(priceText)
        else {
            // Alert verə bilərik
            let alert = UIAlertController(title: "Xəta", message: "Bütün sahələri doldurun", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let newProduct = Product(id: Int.random(in: 1000...9999), name: name, description: description, price: price, imageName: "")
        onSave?(newProduct)
        navigationController?.popViewController(animated: true)
    }
}
