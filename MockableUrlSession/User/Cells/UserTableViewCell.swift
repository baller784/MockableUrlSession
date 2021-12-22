//
//  UserTableViewCell.swift
//  MockableUrlSession
//
//  Created by Daniel Marcenco on 21.12.2021.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    static let reuseIdentifier = "UserTableViewCell"

    private let container = UIStackView(
        axis: .horizontal,
        alignment: .center,
        spacing: 8.0,
        distribution: .fill
    )
    private let labelsStackView = UIStackView(
        axis: .vertical,
        alignment: .leading,
        spacing: 4.0,
        distribution: .fill
    )

    private let pictureImageView: UIImageView = {
        let pictureImageView = UIImageView()
        pictureImageView.layer.borderWidth = 1
        pictureImageView.clipsToBounds = true
        pictureImageView.image = UIImage(systemName: "person.circle")
        return pictureImageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    var viewModel: UserListCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.name
            descriptionLabel.text = viewModel?.description
            if let profileUrl = self.viewModel?.profileImageUrl {
                pictureImageView.load(from: profileUrl)
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        pictureImageView.layer.cornerRadius = pictureImageView.frame.size.width / 2
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
private extension UserTableViewCell {
    func layout() {
        contentView.addSubview(container)

        container.addArrangedSubviews(pictureImageView, labelsStackView)

        labelsStackView.addArrangedSubviews(titleLabel, descriptionLabel)

        container.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(Layout.sideInset)
            $0.top.bottom.equalToSuperview().inset(Layout.topBottomInset)
        }

        pictureImageView.snp.makeConstraints {
            $0.size.equalTo(Layout.pictureImageViewSize)
        }
    }
}

// MARK: - Layout constants
private struct Layout {
    static let sideInset: CGFloat = 16.0
    static let topBottomInset: CGFloat = 8.0
    static let pictureImageViewSize: CGSize = CGSize(width: 60.0, height: 60.0)
}
