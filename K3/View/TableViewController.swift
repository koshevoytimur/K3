//
//  ViewController.swift
//  K3
//
//  Created by Timur Koshevoy on 22.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellId: String = "postCell"
    var cellHeight: CGFloat?
    
    let net = NetworkService()
    var postsArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getPosts()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        createSearchBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPosts()
    }
    
    func getPosts() {
        self.postsArray.removeAll()
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.net.getPostsFromNetwork(with: "text") { (posts, err) in
                
                DispatchQueue.main.async {
                    self.postsArray = posts!
                    self.tableView.reloadData()
                }
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
        
        let imageURL = URL(string: postsArray[indexPath.row].image)
        let imageWidth = CGFloat.init(postsArray[indexPath.row].width)
        let imageHight = CGFloat.init(postsArray[indexPath.row].height)
        
        cell?.postImageView!.sd_setImage(with: imageURL, completed: { (image, error, cache, url) in
            if let error = error {
//                self.alertIssue(error: error)
                print("error")
                return
            }
        })
        
        cell?.summaryLabel.text = postsArray[indexPath.row].summary
        cell?.blogNameLabel.text = postsArray[indexPath.row].blogName
        cell?.tagsLabel.text = postsArray[indexPath.row].tags
        cell?.notesLabel.text = String(postsArray[indexPath.row].notes)
        
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

