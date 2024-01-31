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
            return "trending/movie/week?language=ko-KR"
        case .topRated:
            return "tv/top_rated?language=ko-KR"
        case .popular:
            return "tv/popular?language=ko-KR"
        case .upcoming:
            return "movie/upcoming?language=ko-KR"
        }
    }
}

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    let baseURL = "https://api.themoviedb.org/3/"
    let header: HTTPHeaders = ["Authorization": APIKey.tmdb]
    
    private init() {}
    
    func fetchAPIMovie(apiType: TMDBAPI, completionHandler: @escaping (([Movie]) -> Void)) {
        let url = baseURL + apiType.url
        
        AF.request(url, headers: header).responseDecodable(of: MovieModel.self)
        { response in
            
            switch response.result {
            case .success(let success):
                
                completionHandler(success.results)
                
            case .failure(let failure):
                print("failure: ", failure)
            }
        }
    }
    
    func fetchMovieDetail(movieId: Int, completionHandler: @escaping ((Movie) -> Void)) {
        let url = baseURL + "tv/\(movieId)?language=ko-KR"
        
        AF.request(url, headers: header).responseDecodable(of: Movie.self)
        { response in
            
            switch response.result {
            case .success(let success):
                
                completionHandler(success)
                
            case .failure(let failure):
                print("failure: ", failure)
            }
        }
    }
    
    func fetchSimilarMovies(movieId: Int, completionHandler: @escaping(([Movie]) -> Void)) {
        
        let url = "https://api.themoviedb.org/3/tv/\(movieId)/recommendations?language=ko-KR"
        
        AF.request(url, headers: header).responseDecodable(of: MovieModel.self)
        { response in
            
            switch response.result {
            case .success(let success):
                
                completionHandler(success.results)
                
            case .failure(let failure):
                print("failure: ", failure)
            }
        }
    }
    
    func fetchCastInfo(movieId: Int, completionHandler: @escaping((CastModel) -> Void)) {
        let url = baseURL + "tv/\(movieId)/aggregate_credits"
        
        AF.request(url, headers: header).responseDecodable(of: CastModel.self)
        { response in
            
            switch response.result {
            case .success(let success):
                
                completionHandler(success)
                
            case .failure(let failure):
                print("failure: ", failure)
            }
        }
    }
    
    func fetchMovieImages(id: Int, completionHandler: @escaping (PosterModel) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/images"
        
        AF.request(url, headers: header).responseDecodable(of: PosterModel.self)
        { response in
            
            switch response.result {
            case .success(let success):
                completionHandler(success)
                
            case .failure(let failure):
                dump(failure)
            }
        }
    }
}
