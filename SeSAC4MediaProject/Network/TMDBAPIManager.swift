//
//  TMDBAPIManager.swift
//  SeSAC4Seflix
//
//  Created by Minho on 1/30/24.
//

import Foundation
import Alamofire

enum TMDBAPI {
    case trending, topRated, popular, upcoming
    
    var url: String {
        switch self {
        case .trending:
            return "https://api.themoviedb.org/3/trending/movie/week?language=ko-KR"
        case .topRated:
            return "https://api.themoviedb.org/3/tv/top_rated?language=ko-KR"
        case .popular:
            return "https://api.themoviedb.org/3/tv/popular?language=ko-KR"
        case .upcoming:
            return "https://api.themoviedb.org/3/movie/upcoming?language=ko-KR"
        }
    }
}

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    private init() {}
    
    func fetchAPIMovie(apiType: TMDBAPI, completionHandler: @escaping (([Movie]) -> Void)) {
        let url = apiType.url
        
        let header: HTTPHeaders = ["Authorization": APIKey.tmdb]
        
        AF.request(url, headers: header).responseDecodable(of: MovieModel.self)
        { response in
            
            switch response.result {
            case .success(let success):
//                print("success: ", success)
                
                completionHandler(success.results)
                
            case .failure(let failure):
                print("failure: ", failure)
            }
        }
    }
    
    
    func fetchMovieImages(id: Int, completionHandler: @escaping (PosterModel) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/images"
        
        let header: HTTPHeaders = ["Authorization": APIKey.tmdb]
        
        AF.request(url, headers: header).responseDecodable(of: PosterModel.self)
        { response in
            
            switch response.result {
            case .success(let success):
//                print("success: ", success)
                completionHandler(success)
                
            case .failure(let failure):
                dump(failure)
            }
        }
    }
}
