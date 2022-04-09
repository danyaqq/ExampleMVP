//
//  HomeViewController.swift
//  PostsMVP
//
//  Created by Даня on 09.04.2022.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func getAllPosts()
    func showErrorAlert(error: Error)
}

final class HomeViewController: UIViewController {
    
    //Properties
    var presenter: HomePresenterProtocol?
    
    //Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    
}

//MARK: - Setup views

extension HomeViewController {
    private func setupViews() {
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        title = "Posts"
    }
    
    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeTableViewCell.identifier,
            for: indexPath
        ) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: presenter?.posts?[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = presenter?.posts?[indexPath.row]
        let detailVC = AssemblyModuleBuilder.createDetailModule(post: post)
        detailVC.modalPresentationStyle = .formSheet
        navigationController?.present(detailVC, animated: true, completion: nil)
    }
}

//MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    func getAllPosts() {
        tableView.reloadData()
    }
    
    func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
