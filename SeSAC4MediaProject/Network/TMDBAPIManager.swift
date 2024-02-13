//
//  TMDBAPIManager.swift
//  SeSAC4Seflix
//
//  Created by Minho on 1/30/24.
//

import Foundation
import Alamofire

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    private init() {}
    
    let baseURL = "https://api.themoviedb.org/3/"
    
    func request<T: Decodable, API: APIProtocol>(type: T.Type, api: API,
                               completionHandler: @escaping ((T) -> Void)) {
       
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: type)
        { response in
            
            switch response.result {
            case .success(let success):
                completionHandler(success)
                
            case .failure(let failure):
                dump(failure)
                
            }
        }
    }
    
    func fetchMovieImages(api: TMDBAPI, completionHandler: @escaping (PosterModel) -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: PosterModel.self) { response in
            
            switch response.result {
            case .success(let success):
                // print("success: ", success)
                completionHandler(success)
                
            case .failure(let failure):
                print("failure: ", failure)
            }
        }
    }
    
    func fetchCastInfo(id: Int, completionHandler: @escaping ([Cast]) -> Void) {
        let url = "https://api.themoviedb.org/3/tv/\(id)/aggregate_credits"
        let header: HTTPHeaders = ["Authorization": APIKey.tmdb]

        AF.request(url, headers: header).responseDecodable(of: CastModel.self) { response in
            switch response.result {
                
            case .success(let success):
                
                completionHandler(success.cast)
                
            case .failure(let failure):
                
                dump(failure)
            }
        }
    }
}
