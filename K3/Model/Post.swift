//
//  Post.swift
//  K3
//
//  Created by Timur Koshevoy on 22.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    struct Response: Codable {
        var type: String?
        var blog_name: String?
    }
    
    var response: [Response]
}
