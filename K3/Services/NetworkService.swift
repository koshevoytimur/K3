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
                
                
                if responseItem["type"].stringValue == "photo"{
                    var image: String = ""
                    var width: Int = 0
                    var height: Int = 0
                    
                    if responseItem["photos"].arrayValue.count > 0 {
                        for itemPhotos in responseItem["photos"].arrayValue {
                            image = itemPhotos["original_size"]["url"].stringValue
                            width = itemPhotos["original_size"]["width"].intValue
                            height = itemPhotos["original_size"]["height"].intValue
                        }
                    }
                    self.postsArray.append(Post(type: responseItem["type"].stringValue, blogName: responseItem["blog_name"].stringValue, image: image, width: width, height: height, summary: responseItem["summary"].stringValue, tags: tags, notes: responseItem["note_count"].intValue))
                }
                
            }
            
            completion(self.postsArray, nil)
            print(self.postsArray[0].blogName)
            print(self.postsArray[0].height)
            print(self.postsArray[0].width)
            print(self.postsArray[0].image)
            print(self.postsArray[0].notes)
            print(self.postsArray[0].summary)
            print(self.postsArray[0].tags)
            print(self.postsArray[0].type)
        }
        
    }
    
}
