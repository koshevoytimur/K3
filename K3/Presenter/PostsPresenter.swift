//
//  PostsPresenter.swift
//  K3
//
//  Created by Тимур Кошевой on 25.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import Foundation

class PostsPresenter {
    
    let network = NetworkService()
    let serializer = PostSerializer()
    
    func fetchPosts(tag: String, completion: @escaping (_ : [Post]?, _ error: String?) -> Void) {
        
        network.getPostsFromNetwork(tag: tag) { (postsData, error) in
            
            if let error = error {
                completion(nil, error)
            }
            
            if let postsData = postsData {
                let posts = self.serializer.serializePostsList(data: postsData)
                completion(posts, nil)
            } else {
                completion(nil, "Network issue occur!")
            }
            
        }
    }
    
}
