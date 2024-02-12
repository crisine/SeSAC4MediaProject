//
//  TMDBAPI.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/2/24.
//

import Foundation
import Alamofire

protocol APIProtocol {
    var endpoint: URL { get }
    var header : HTTPHeaders { get }
    var method : HTTPMethod { get }
    var parameter : Parameters { get }
}

enum TMDBAPI: APIProtocol {
    
    case trending
    case search(query: String)
    case photo(id: Int)
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
        case .upcoming:
            ["": ""]
        case .detail:
            ["language": "ko-KR"]
        case .similar:
            ["language": "ko-KR"]
        }
    }
    
}

enum TMDBTVAPI: APIProtocol {
    
    case search(query: String)
    case detail(seriesID: String)
    case airing
    case trending
    case topRated
    case popular
    case similar(seriesID: String)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .search(let query):
            return URL(string: baseURL + "search/tv")!
        case .detail(let seriesID):
            return URL(string: baseURL + "tv/\(seriesID)/episode_groups")!
        case .airing:
            return URL(string: baseURL + "tv/airing_today")!
        case .trending:
            return URL(string: baseURL + "trending/tv/week")!
        case .topRated:
            return URL(string: baseURL + "tv/top_rated")!
        case .popular:
            return URL(string: baseURL + "tv/popular")!
        case .similar(let seriesID):
            return URL(string: baseURL + "tv/\(seriesID)/similar")!
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
        case .search(let query):
            ["language": "ko-KR", "query": query]
        case .detail:
            ["language": "ko-KR"]
        case .airing:
            ["language": "ko-KR"]
        case .trending:
            ["language": "ko-KR"]
        case .topRated:
            ["language": "ko-KR"]
        case .popular:
            ["language": "ko-KR"]
        case .similar:
            ["language": "ko-KR"]
        }
    }
    
}

