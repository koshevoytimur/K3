//
//  DecodeService.swift
//  K3
//
//  Created by Timur Koshevoy on 22.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

//import Foundation
//
//class DecodeService {
//    
//    var post: Post?
// 
//    func decodeJson() {
//        
//            let jsonUrlString = "https://api.tumblr.com/v2/tagged?tag=meme&api_key=CcEqqSrYdQ5qTHFWssSMof4tPZ89sfx6AXYNQ4eoXHMgPJE03U"
//        
//            guard let url = URL(string: jsonUrlString) else { return }
//            
//            URLSession.shared.dataTask(with: url) { (data, response, err) in
//                guard let data = data else { return }
//                do {
//                    self.post = try? JSONDecoder().decode(Post.self, from: data)
//                    print(self.post)
//                }
//            }.resume()
//    }
//    
//}
