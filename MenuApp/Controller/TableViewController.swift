//
//  TableViewController.swift
//  MenuApp
//
//  Created by Aysu Sadikhova on 26.08.25.
//

import UIKit

class GenericTableViewController<Item, Cell: UITableViewCell>: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView = UITableView()
    private let items: [Item]
    private let configureCell: (Cell, Item) -> Void
    private let didSelectItem: ((Item) -> Void)?

    init(items: [Item],
         configureCell: @escaping (Cell, Item) -> Void,
         didSelectItem: ((Item) -> Void)? = nil,
         title: String? = nil) {
        self.items = items
        self.configureCell = configureCell
        self.didSelectItem = didSelectItem
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        configureCell(cell, item)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelectItem?(item)
    }
}

