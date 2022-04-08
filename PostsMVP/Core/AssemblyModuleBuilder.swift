//
//  AssemblyModuleBuilder.swift
//  PostsMVP
//
//  Created by Даня on 09.04.2022.
//

import Foundation
import UIKit

protocol AssemblyModuleBuilderProtocol {
    static func createHomeModule() -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyModuleBuilderProtocol {
    static func createHomeModule() -> UIViewController {
        let view = HomeViewController()
        let networkService = NetworkService()
        let presenter = HomePresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    
    
}
