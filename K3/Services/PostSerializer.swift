//
//  PostSerializer.swift
//  K3
//
//  Created by Timur Koshevoy on 22.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import SwiftyJSON

class PostSerializer {
    
    func serializePostsList(data: Data) -> [Post] {
        let json = JSON(data)
        return json["response"].arrayValue.map(self.serializePost)
    }
    
    func serializePost(responseItem: JSON) -> Post {
        
        let tags: [String] = responseItem["tags"].arrayValue.map{ tag in
            return tag.stringValue
        }
        
        let width: Int = 100
        let height: Int = 100
        var image: String = ""
        let placeHolderImage = "https://img.icons8.com/color/96/000000/ios-application-placeholder.png"
        
        if responseItem["type"].stringValue == "photo" {
            if responseItem["photos"].arrayValue.count > 0 {
                let images = responseItem["photos"].arrayValue.map{ photo in
                    return Image(url: photo["original_size"]["url"].stringValue,
                                 width: photo["original_size"]["width"].intValue,
                                 height: photo["original_size"]["height"].intValue)
                }
                
                
                return Post(type: responseItem["type"].stringValue,
                            blogName: responseItem["blog_name"].stringValue,
                            images: images,
                            summary: responseItem["summary"].stringValue,
                            tags: tags,
                            notes: responseItem["note_count"].intValue)
            } else {
                let images = [Image(url: placeHolderImage,
                                    width: width,
                                    height: height)]
                
                return Post(type: responseItem["type"].stringValue,
                            blogName: responseItem["blog_name"].stringValue,
                            images: images,
                            summary: responseItem["summary"].stringValue,
                            tags: tags,
                            notes: responseItem["note_count"].intValue)
            }
        } else {
            let images = [Image(url: placeHolderImage,
                                width: width,
                                height: height)]
            
            return Post(type: responseItem["type"].stringValue,
                        blogName: responseItem["blog_name"].stringValue,
                        images: images,
                        summary: responseItem["summary"].stringValue,
                        tags: tags,
                        notes: responseItem["note_count"].intValue)
        }
    }
    
}
