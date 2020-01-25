//
//  Images.swift
//  K3
//
//  Created by Тимур Кошевой on 25.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import Foundation

class Image {
    
    var url: String
    var width: Int
    var height: Int
    
    init(url: String, width: Int, height: Int) {
        self.url = url
        self.height = height
        self.width = width
    }
}
