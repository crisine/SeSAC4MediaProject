//
//  NaverAPIManager.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/14/24.
//

import Alamofire

final class NaverAPIManager {

    static let shared = NaverAPIManager()

    private init() { }
    
    func fetchImage(query: String,
                     start: Int,
                     completionHandler: @escaping ((NaverImageModel?, AFError?) -> Void)) {
        
        let url = "https://openapi.naver.com/v1/search/image"

        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverHeaderClient,
            "X-Naver-Client-Secret": APIKey.naverHeaderKey
        ]

        let parameters: Parameters = [
            "query": query,
            "start": start,
            "display": "30",
        ]

        AF.request(url, 
                   method: .get,
                   parameters: parameters,
                   headers: headers)
          .responseDecodable(of: NaverImageModel.self) { response in
              
            switch response.result {
            
            case .success(let success):
                completionHandler(success, nil)

            case .failure(let failure):
                completionHandler(nil, failure)
                
            }
        }
    }
}
