//
//  NetworkService.swift
//  K3
//
//  Created by Timur Koshevoy on 23.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {
        
    var postsArray = [Post]()

    let url = URL(string: "https://api.tumblr.com/v2/tagged?tag=meme&api_key=CcEqqSrYdQ5qTHFWssSMof4tPZ89sfx6AXYNQ4eoXHMgPJE03U")
    
    func getPostsFromNetwork(with tag: String, completion: @escaping (_ response: Post?, _ error: String?) -> Void) {
        
        AF.request(url!, method: .get ).responseJSON { (responseData) in
            
            guard responseData.response != nil else {
                completion(nil, "Error")
                return
            }
            
            let json = JSON(responseData.data)
            
            for responseItem in json["response"].arrayValue {
                var tags: String = ""
                if responseItem["tags"].arrayValue.count > 0 {
                    for tagItem in responseItem["tags"].arrayValue {
                        tags = tags + " #" + tagItem.stringValue
                    }
                }
                
                
                
                
                
            }
            print(json)
            
        }
        
    }
    
}
