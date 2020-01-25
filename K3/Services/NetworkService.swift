//
//  NetworkService.swift
//  K3
//
//  Created by Timur Koshevoy on 23.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    private func makeURL(tag: String) -> URL{
        
        let baseURL = "http://api.tumblr.com/v2/"
        let apiKey = "CcEqqSrYdQ5qTHFWssSMof4tPZ89sfx6AXYNQ4eoXHMgPJE03U"
        return URL(string: "\(baseURL)tagged?tag=\(tag)&api_key=\(apiKey)")!
    }
    
    func getPostsFromNetwork(tag: String, completion: @escaping (_ response: Data?, _ error: String?) -> Void) {
        
        AF.request(makeURL(tag: tag), method: .get ).responseJSON { (responseData) in
            guard responseData.response != nil else {
                print("Fail to load from network")
                completion(nil, "Fail to load from network")
                return
            }
            let data = responseData.data
            
            completion(data, nil)
        }
    }
    
}
