//
//  HomePresenter.swift
//  PostsMVP
//
//  Created by Даня on 09.04.2022.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    init(view: HomeViewProtocol, networkService: NetworkServiceProtocol)
    var posts: [Post]? { get set }
    func getPosts()
}

class HomePresenter: HomePresenterProtocol {
    
    //Properties
    weak var view: HomeViewProtocol?
    let networkService: NetworkServiceProtocol?
    var posts: [Post]?
    
    //Init
    required init(view: HomeViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        
        getPosts()
    }
    
    //Methods
    func getPosts() {
        networkService?.getPosts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                    self.view?.getAllPosts()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showErrorAlert(error: error)
                }
            }
        }
    }
    
}
