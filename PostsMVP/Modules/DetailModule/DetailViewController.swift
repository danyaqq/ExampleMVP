//
//  DetailViewController.swift
//  PostsMVP
//
//  Created by Даня on 09.04.2022.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func configureViews(with post: Post?)
}

class DetailViewController: UIViewController {
    
    //Properties
    var presenter: DetailPresenterProtocol?
    
    //Views
    private let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topTitleLabel, mainTitleLabel])
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bottomBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let mainBodyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var bottomStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bottomBodyLabel, mainBodyLabel])
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
}

//MARK: - Setup views

extension DetailViewController {
    func setupViews() {
        view.frame = UIScreen.main.bounds
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(topStackView)
        view.addSubview(bottomStackView)
    }
    
    func setupConstraints() {
        topStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 16).isActive = true
        bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
}

//MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func configureViews(with post: Post?) {
        mainTitleLabel.text = post?.title
        mainBodyLabel.text = post?.body
    }
}
