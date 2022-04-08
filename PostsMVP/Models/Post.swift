//
//  Post.swift
//  PostsMVP
//
//  Created by Даня on 09.04.2022.
//

import Foundation


struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
