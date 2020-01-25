//
//  PostsViewController.swift
//  K3
//
//  Created by Timur Koshevoy on 22.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import UIKit
import SDWebImage

class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellId: String = "postCell"
    var cellHeight: CGFloat?
    
    var postsArray = [Post]()
    let presenter = PostsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getPosts("lol")
        createSearchBar()
    }
    
    func getPosts(_ tag: String) {
        self.postsArray.removeAll()
        presenter.fetchPosts(tag: tag) { (posts, error) in
            if let error = error {
                print(error)
            } else {
                self.postsArray = posts!
                self.tableView.reloadData()
            }
        }
    }
    
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsArray.count
    }
    
    func createPostCell() -> PostCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as? PostCell
        
        if cell == nil {
            let nib = Bundle.main.loadNibNamed("PostCell", owner: self, options: nil)
            cell = nib?[0] as? PostCell
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = createPostCell()
        let post = postsArray[indexPath.row]
        cell.processFromPost(post: post)
        cellHeight = cell.calculateHeight(post: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight!
    }
    
}

extension PostsViewController: UISearchBarDelegate {
    
    private func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search by tag"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        if !searchBar.text!.isEmpty {
            getPosts(searchBar.text!)
        }
    }
    
}

