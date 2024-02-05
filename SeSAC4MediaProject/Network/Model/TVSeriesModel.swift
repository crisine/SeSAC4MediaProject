//
//  TVSeriesModel.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 1/31/24.
//

import Foundation

struct TVSeriesModel: Decodable {
    let page: Int
    let results: [TVSeries]
}

struct TVSeries: Decodable {
    let original_name: String?
    let name: String?
    let overview: String
    let poster_path: String?
    let genres: [Genre]?
    let vote_average: Double
    let vote_count: Int
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

