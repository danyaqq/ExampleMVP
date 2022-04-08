//
//  HomeTableViewCell.swift
//  PostsMVP
//
//  Created by Даня on 09.04.2022.
//

import Foundation
import UIKit

class HomeTableViewCell: UITableViewCell {
    
    //Properties
    static let identifier = "HomeTableViewCell"
    
    //Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chevronImage: UIImageView = {
        let image = UIImage(systemName: "chevron.right")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .blue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, chevronImage])
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Configure & setup cell
extension HomeTableViewCell {
    func configure(with title: String?) {
        titleLabel.text = title
    }
    
    func setupView() {
        contentView.addSubview(horizontalStackView)
    }
    
    func setupConstraints() {
        horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor).isActive = true
        
        chevronImage.widthAnchor.constraint(equalToConstant: 10).isActive = true
        chevronImage.trailingAnchor.constraint(equalTo: horizontalStackView.trailingAnchor).isActive = true
    }
}
