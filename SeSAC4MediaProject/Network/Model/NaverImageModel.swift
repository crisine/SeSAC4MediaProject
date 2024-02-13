//
//  NaverImageModel.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/14/24.
//

struct NaverImageModel: Decodable {
    let total: Int
    let start: Int
    let display: Int
    let items: [NaverImage]
}

struct NaverImage: Decodable {
    let title: String
    let link: String
    let thumbnail: String
    let sizeheight: String
    let sizewidth: String
}
