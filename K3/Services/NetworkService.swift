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
    
    func getPostsFromNetwork(with tag: String, completion: @escaping (_ response: [Post]?, _ error: String?) -> Void) {
        
        postsArray.removeAll()
        
        AF.request(url!, method: .get ).responseJSON { (responseData) in
            
            guard responseData.response != nil else {
                print("Error")
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
                var width: Int = 100
                var height: Int = 100
                var image: String = ""
                
                switch responseItem["type"].stringValue {
                case "photo":
                    
                    if responseItem["photos"].arrayValue.count > 0 {
                        for itemPhotos in responseItem["photos"].arrayValue {
                            image = itemPhotos["original_size"]["url"].stringValue
                            width = itemPhotos["original_size"]["width"].intValue
                            height = itemPhotos["original_size"]["height"].intValue
                            
                            self.postsArray.append(Post(type: responseItem["type"].stringValue, blogName: responseItem["blog_name"].stringValue, image: image, width: width, height: height, summary: responseItem["summary"].stringValue, tags: tags, notes: responseItem["note_count"].intValue))
                        }
                    }
                default:
                    image = "https://img.icons8.com/dotty/80/000000/ios-application-placeholder.png"
                    self.postsArray.append(Post(type: responseItem["type"].stringValue, blogName: responseItem["blog_name"].stringValue, image: image, width: width, height: height, summary: responseItem["summary"].stringValue, tags: tags, notes: responseItem["note_count"].intValue))
                }
                
            }
            //            print(json)
            completion(self.postsArray, nil)
            
            print("count: \(self.postsArray.count)")
        }
        
    }
    
}
