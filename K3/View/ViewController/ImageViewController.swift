//
//  ImageViewController.swift
//  K3
//
//  Created by Тимур Кошевой on 26.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import UIKit
import SDWebImage

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return scroll
    }()
    
    var post: Post?
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        setupImages(post!)
        setupLabel(post: post!)
    }
    
    func setupLabel(post: Post) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.textAlignment = .center
        label.text = post.blogName
        self.navigationItem.titleView = label
    }
    
    func setupImages(_ post: Post){
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true

        for i in 0..<post.images.count {
            
            let imageURL = URL(string: post.images[i].url)
            
            let imageView = UIImageView()
            
            imageView.sd_setImage(with: imageURL, completed: { (image, error, cache, url) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            })
            
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }
    }
    
}
