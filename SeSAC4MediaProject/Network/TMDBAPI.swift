//
//  TMDBAPI.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/2/24.
//

import Foundation
import Alamofire

enum TMDBAPI {
    
    case trending
    case search(query: String)
    case photo(id: Int)
    case topRated
    case popular
    case upcoming
    case detail(id: Int)
    case similar(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/movie/week")!
        case .search:
            return URL(string: baseURL + "search/movie")!
        case .photo:
            return URL(string: baseURL + "movie/{id}/images")!
        case .topRated:
            return URL(string: baseURL + "tv/top_rated")!
        case .popular:
            return URL(string: baseURL + "tv/popular")!
        case .upcoming:
            return URL(string: baseURL + "movie/upcoming")!
        case .detail(let id):
            return URL(string: baseURL + "tv/\(id)")!
        case .similar(let id):
            return URL(string: baseURL + "tv/\(id)/recommendations")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdb]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .trending:
            ["": ""]
        case .search(let query):
            ["language": "ko-KR", "query": query]
        case .photo:
            ["": ""]
        case .topRated:
            ["": ""]
        case .popular:
            ["": ""]
        case .upcoming:
            ["": ""]
        case .detail:
            ["language": "ko-KR"]
        case .similar:
            ["language": "ko-KR"]
        }
    }
    
}
