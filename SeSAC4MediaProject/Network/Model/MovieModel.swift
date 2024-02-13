//
//  MovieModel.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 1/31/24.
//

import Foundation


struct MovieModel: Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let name: String?
    let title: String?
    let original_name: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case title
        case original_name = "original_name"
        case original_title = "original_title"
        case overview
        case poster_path = "poster_path"
        case backdrop_path = "backdrop_path"
    }
}
