//
//  CategoriesViewController.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 25.08.25.
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
    
    private var collectionDataSource: UICollectionViewDiffableDataSource<Int, Category>!
    private var tableDataSource: UITableViewDiffableDataSource<Int, AnyHashable>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Menyu"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        setupCollectionView()
        setupTableView()
        setupLayout()

        MenuDataManager.shared.initializeDefaultMenuIfNeeded()
        
        viewModel.loadMenu()
    }
    
    
    private func setupCollectionView() {
        topCollectionView.showsHorizontalScrollIndicator = false
        topCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(topCollectionView)
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionDataSource = UICollectionViewDiffableDataSource<Int, Category>(collectionView: topCollectionView) { collectionView, indexPath, category in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            let label = UILabel()
            label.text = category.name
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14, weight: .medium)
            cell.contentView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])
            
            cell.backgroundColor = (indexPath.item == self.viewModel.selectedCategoryIndex) ? .systemOrange : .systemGray5
            cell.layer.cornerRadius = 12
            return cell
        }
        
        topCollectionView.delegate = self
    }
    
    private func setupTableView() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "categoryCell")
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60

        tableDataSource = UITableViewDiffableDataSource<Int, AnyHashable>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell

            if let subcategory = item as? Subcategory {
                cell.configure(with: subcategory.name)
            } else if let product = item as? Product {
                cell.configure(with: product.name)
            } else {
                cell.configure(with: "")
            }

            return cell
        }

        tableView.delegate = self
    }


    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            topCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            topCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            topCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            topCollectionView.heightAnchor.constraint(equalToConstant: 60),

            tableView.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
    }
    
    private func updateCollectionSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Category>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.categories)
        collectionDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func updateTableSnapshot() {
        guard let category = viewModel.categories[safe: viewModel.selectedCategoryIndex] else { return }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>()
        snapshot.appendSections([0])
        
        if let subs = category.subcategories, !subs.isEmpty {
            snapshot.appendItems(subs.map { $0 as AnyHashable })
        } else if let products = category.products, !products.isEmpty {

            snapshot.appendItems(products.map { $0 as AnyHashable })
        }
        
        tableDataSource.apply(snapshot, animatingDifferences: true)
        
    }



}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedCategoryIndex = indexPath.item
        updateCollectionSnapshot()
        updateTableSnapshot()
        
        for cell in collectionView.visibleCells {
            if let index = collectionView.indexPath(for: cell) {
                cell.backgroundColor = (index.item == viewModel.selectedCategoryIndex) ? .systemOrange : .systemGray5
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = viewModel.categories[indexPath.item].name
        let width = (text as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium)]).width + 24
        return CGSize(width: width, height: 45)
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = viewModel.categories[viewModel.selectedCategoryIndex]
        
        if let subcategories = category.subcategories, indexPath.row < subcategories.count {
            let subcategory = subcategories[indexPath.row]
            
            let products = MenuDataManager.shared.getProductsForSubcategory(subcategoryId: subcategory.id)
            
            let productsVC = TableViewController<Product, ProductCell>(
                items: products,
                configureCell: { cell, product in
                    cell.configure(with: product)
                },
                title: subcategory.name
            )
            productsVC.subcategoryId = subcategory.id
            navigationController?.pushViewController(productsVC, animated: true)
        }
    }
}

extension CategoriesViewController: CategoriesViewModelDelegate {
    func didLoadMenu() {
        updateCollectionSnapshot()
        updateTableSnapshot()
    }

    func didFailLoadingMenu(error: Error) {
        print("Error loading menu: \(error.localizedDescription)")
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
