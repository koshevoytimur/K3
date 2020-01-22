//
//  ViewController.swift
//  K3
//
//  Created by Timur Koshevoy on 22.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let decode = DecodeService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decode.decodeJson()
        
    }


}

