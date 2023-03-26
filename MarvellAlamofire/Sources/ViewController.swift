//
//  ViewController.swift
//  MarvellAlamofire
//
//  Created by Вячеслав Онучин on 18.03.2023.
//

import UIKit

class ViewController: UIViewController {

    let networkService = NetworkService()
    var model: MarvellAnswer?

    // MARK: - Outlets

    //    private lazy var topImage: UIImageView = {
    //        let image = UIImageView()
    //        image.image = UIImage(named: "marvell")
    //        image.contentMode = .scaleAspectFill
    //        return image
    //    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reusID)
        return collectionView
    }()

    func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(200))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 8,
            bottom: 0,
            trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(200))

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(8)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 0,
            bottom: 16,
            trailing: 0)

        return UICollectionViewCompositionalLayout(section: section)
    }



    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupHierarchy()
        setupLayout()

        networkService.getData(url: networkService.addURL()) { result in
            switch result {
            case .success(let data):
                self.model = data
                self.collectionView.reloadData()
                print(self.model ?? "")

            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: - Setups

    private func setupHierarchy() {
        view.addSubviewsForAutoLayout([
            collectionView
        ])
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         model?.data?.results.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reusID, for: indexPath) as? CustomCell
        else {
            return UICollectionViewCell()
        }
        let character = model?.data?.results[indexPath.row]
        cell.configurate(by: character)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


