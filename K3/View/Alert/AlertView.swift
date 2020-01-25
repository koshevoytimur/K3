//
//  AlertView.swift
//  K3
//
//  Created by Тимур Кошевой on 25.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import UIKit

class AlertView: NSObject {
    func showAlert(view: UIViewController , title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
}
