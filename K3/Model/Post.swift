//
//  Post.swift
//  K3
//
//  Created by Timur Koshevoy on 22.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import Foundation

//struct Post: Codable {
//
//    struct Response: Codable {
//        var type: String?
//        var blog_name: String?
//    }
//
//    var response: [Response]
//}


class Post {
    
    var type: String
    var blogName: String
    var image: String
    var width: Int
    var height: Int
    var summary: String
    var tags: String
    var notes: Int
    
    init(type: String, blogName: String, image: String, width: Int, height: Int, summary: String, tags: String, notes: Int) {
        
        self.type = type
        self.blogName = blogName
        self.image = image
        self.width = width
        self.height = height
        self.summary = summary
        self.tags = tags
        self.notes = notes
    }
}
