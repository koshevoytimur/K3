//
//  ImageViewController.swift
//  K3
//
//  Created by Тимур Кошевой on 26.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
