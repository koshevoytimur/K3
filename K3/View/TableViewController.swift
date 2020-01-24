//
//  ViewController.swift
//  K3
//
//  Created by Timur Koshevoy on 22.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellId: String = "postCell"
    var cellHeight: CGFloat?
    
    let net = NetworkService()
    var postsArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getPosts()
        
        createSearchBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPosts()
    }
    
    func getPosts() {
        net.getPostsFromNetwork(with: "lol") { (posts, err) in
            self.postsArray = posts!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as? TableViewCell
        
        if cell == nil {
            let nib = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)
            cell = nib?[0] as? TableViewCell
        }
        
        let imageWidth = CGFloat.init(postsArray[indexPath.section].width)
        let imageHight = CGFloat.init(postsArray[indexPath.section].height)
        
//        cell?.userNameLabel.text = postsArray[indexPath.section].blogName
        cell?.userNameLabel.text = "hey"
        
        cellHeight = cell?.dynamicHight(screenWidth: tableView.frame.width, imageWidth: imageWidth, imageHight: imageHight)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight!
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

