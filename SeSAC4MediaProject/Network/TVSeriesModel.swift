//
//  TVSeriesModel.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 1/31/24.
//

import Foundation

struct TVSeries {
    let original_name: String
    let name: String
    let overview: String
    let poster_path: String
    let genres: [Genre]
}

struct Genre {
    let id: Int
    let name: String
}

