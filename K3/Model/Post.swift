//
//  Post.swift
//  K3
//
//  Created by Timur Koshevoy on 22.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import Foundation

class Post {
    
    var type: String
    var blogName: String
    var images: [Image]
    var summary: String
    var tags: [String]
    var notes: Int
    
    init(type: String, blogName: String, images: [Image], summary: String, tags: [String], notes: Int) {
        
        self.type = type
        self.blogName = blogName
        self.images = images
        self.summary = summary
        self.tags = tags
        self.notes = notes
    }
}
