//
//  NetworkService.swift
//  PostsMVP
//
//  Created by Даня on 09.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(decodedData))
            } catch let err {
                completion(.failure(err))
            }
        }
        task.resume()
    }
    
}
