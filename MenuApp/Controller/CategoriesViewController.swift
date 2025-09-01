//
//  CategoriesViewController.swift
//  MenuApp
//
//  Created by Aysu Sadıxova on 25.08.25.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    private lazy var viewModel: CategoriesViewModelProtocol = {
        let vm = CategoriesViewModelImpl()
        vm.delegate = self
        return vm
    }()

    private let topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private let tableView = UITableView()
    private var selectedCategoryIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Menyu"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        setupCollectionView()
        setupTableView()
        setupLayout()

        viewModel.delegate = self
        viewModel.loadMenu()
    }
    
    private func setupCollectionView() {
        topCollectionView.dataSource = self
        topCollectionView.delegate = self
        topCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        topCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(topCollectionView)
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            topCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            topCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            topCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            topCollectionView.heightAnchor.constraint(equalToConstant: 60),

            tableView.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let label = UILabel()
        label.text = viewModel.categories[indexPath.item].name
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        cell.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])

        cell.backgroundColor = (indexPath.item == viewModel.selectedCategoryIndex) ? .systemOrange : .systemGray5
        cell.layer.cornerRadius = 12
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedCategoryIndex = indexPath.item
        collectionView.reloadData()
        tableView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = viewModel.categories[indexPath.item].name
        let width = (text as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium)]).width + 24
        return CGSize(width: width, height: 40)
    }
}


extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSelectedCategory()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.titleForRow(at: indexPath.row)
        return cell
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = viewModel.categories[viewModel.selectedCategoryIndex]
        guard let subcategories = category.subcategories, indexPath.row < subcategories.count else { return }
        let subcategory = subcategories[indexPath.row ]
        guard let products = subcategory.products else { return }

        let productsVC = TableViewController<Product, ProductCell>(
            items: products,
            configureCell: { cell, product in
                cell.configure(with: product)
            },
            title: subcategory.name
        )
        navigationController?.pushViewController(productsVC, animated: true)

    }
}



extension CategoriesViewController: CategoriesViewModelDelegate {
    func didLoadMenu() {
        topCollectionView.reloadData()
        tableView.reloadData()
    }

    func didFailLoadingMenu(error: Error) {
        print("Error loading menu: \(error.localizedDescription)")
    }

}

