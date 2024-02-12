//
//  PosterModel.swift
//  SeSAC4Seflix
//
//  Created by Minho on 1/30/24.
//

import Foundation

struct PosterModel: Decodable {
    let posters: [Poster]
}

struct Poster: Decodable {
    let file_path: String
}
