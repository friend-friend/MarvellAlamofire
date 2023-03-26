//
//  CustomCell.swift
//  MarvellAlamofire
//
//  Created by Вячеслав Онучин on 20.03.2023.
//

import UIKit

class CustomCell: UICollectionViewCell {

    static let reusID = "CustomCell"

    // MARK: - Outlets

    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.startAnimating()
        return indicator
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        contentView.addSubviewsForAutoLayout([
            avatarImageView,
            nameLabel,
            activityIndicator])
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            nameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -24),
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }


    // MARK: - Configuration

    func configurate(by model: Character?) {
        guard let model = model else { return }

        nameLabel.text = model.name
        DispatchQueue.global().async {
            guard let imagePath = model.thumbnail?.path,
                  let imageFormat = model.thumbnail?.format,
                  let imageUrl = URL(string: "\(imagePath).\(imageFormat)"),
                  let imageData = try? Data(contentsOf: imageUrl)
            else { return }

            let image = UIImage(data: imageData)

            DispatchQueue.main.async {
                self.avatarImageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }
    }
}


