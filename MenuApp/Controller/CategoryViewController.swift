import UIKit

class CategoriesViewController: UIViewController {

    private let topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 18
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private let tableView = UITableView()
    private var selectedCategoryIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Menyu"
        navigationController?.navigationBar.prefersLargeTitles = true


        // Top CollectionView
        topCollectionView.dataSource = self
        topCollectionView.delegate = self
        topCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        topCollectionView.showsHorizontalScrollIndicator = false

        // TableView
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Layout
        view.addSubview(topCollectionView)
        view.addSubview(tableView)

        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            topCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            topCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
        CategoriesData.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        // Label əlavə edirik
        let label = UILabel()
        label.text = CategoriesData.categories[indexPath.item].name
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)

        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])

        cell.backgroundColor = (indexPath.item == selectedCategoryIndex) ? .systemBlue : .systemGray5
        cell.layer.cornerRadius = 12

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath.item
        collectionView.reloadData()
        tableView.reloadData()
    }

    // Cell ölçüsü
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = CategoriesData.categories[indexPath.item].name
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium)]).width + 24
        return CGSize(width: width, height: 40)
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CategoriesData.categories[selectedCategoryIndex].children?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let child = CategoriesData.categories[selectedCategoryIndex].children?[indexPath.row]
        cell.textLabel?.text = child?.name
        return cell
    }
}
