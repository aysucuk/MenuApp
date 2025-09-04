//
//  NewProductViewController.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 02.09.25.
//

import UIKit

class NewProductViewController: UIViewController {
    
    var subcategoryId: Int?
    
    private lazy var viewModel: NewProductViewModelProtocol = {
        let vm = AddProductViewModelImpl()
        vm.onProductCreated = { [weak self] product in
            self?.onSave?(product)
            self?.navigationController?.popViewController(animated: true)
        }
        return vm
    }()

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
    
    var onSave: ((Product) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Yeni Məhsul"
        setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(saveTapped)
        )
    }

    @objc private func saveTapped() {
        viewModel.createProduct(
            name: nameField.text,
            description: descriptionField.text,
            priceText: priceField.text,
            subcategoryId: subcategoryId
        )
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
}
