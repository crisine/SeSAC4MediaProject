//
//  TMDBSessionManager.swift
//  SeSAC4Seflix
//
//  Created by Minho on 2/5/24.
//

import Foundation

enum SeSACError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
    case invalidURL
}

class TMDBSessionManager {
    
    static let shared = TMDBSessionManager()
    
    func fetchTVSeries(api: TMDBAPI, query: [String: String], completionHandler: @escaping (TVSeriesModel?, SeSACError?) -> Void) {
        
        guard var urlComponents = URLComponents(string: api.endpoint.absoluteString) else {
            return
        }
        
        // query를 url에 추가하기 위해서는 다음과 같은 과정을 거쳐야 함
        let queryItemArray = query.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        // 위에서 요청을 보내려는 URL에 Query Items를 붙여주는 과정
        urlComponents.queryItems = queryItemArray
        
        guard let url = urlComponents.url else {
            completionHandler(nil, .invalidURL)
            return
        }
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "GET"
        requestURL.addValue(APIKey.tmdb, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(TVSeriesModel.self, from: data)
                    dump(result)
                    completionHandler(result, nil)
                } catch {
                    
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
            
        }.resume()
    }
    
}
