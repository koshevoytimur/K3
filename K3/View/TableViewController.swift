//
//  ViewController.swift
//  K3
//
//  Created by Timur Koshevoy on 22.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        
        let net = NetworkService()
        
        net.getPostsFromNetwork(with: "lol") { (post, err) in
            print("DONE")
        }
        
    }
    
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}

extension TableViewController: UISearchBarDelegate {
    private func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search by tag"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
}

