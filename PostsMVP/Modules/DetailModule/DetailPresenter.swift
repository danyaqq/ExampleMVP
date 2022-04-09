//
//  DetailPresenter.swift
//  PostsMVP
//
//  Created by Даня on 09.04.2022.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, post: Post?)
    var post: Post? { get }
    func configureView()
}

class DetailPresenter: DetailPresenterProtocol {
    
    //Properties
    weak var view: DetailViewProtocol?
    var post: Post?
    
    //Init
    required init(view: DetailViewProtocol, post: Post?) {
        self.view = view
        self.post = post
        
        configureView()
    }
    
    //Methods
    func configureView() {
        view?.configureViews(with: post)
    }
}
