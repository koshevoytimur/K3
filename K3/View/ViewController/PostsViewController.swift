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
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let cellId: String = "postCell"
    var cellHeight: CGFloat?
    
    let alert = AlertView()
    var postsArray = [Post]()
    let presenter = PostsPresenter()
    
    // MARK: - Functions
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
                self.showAlert(title: "Error", message: error)
            } else {
                self.postsArray = posts!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        self.alert.showAlert(view: self, title: title, message: message)
    }
    
}

// MARK: - TableView
extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsArray.count
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
    
    func createPostCell() -> PostCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as? PostCell
        
        if cell == nil {
            let nib = Bundle.main.loadNibNamed("PostCell", owner: self, options: nil)
            cell = nib?[0] as? PostCell
        }
        
        cell!.buttonTappedAction = { cell in
            self.readButtonTapped(cell: cell!)
        }
        
        return cell!
    }
    
    func readButtonTapped(cell: UITableViewCell) {
        let index = self.tableView.indexPath(for: cell)?.row
        self.openImageOnNextScreen(index: index!)
    }
    
    func openImageOnNextScreen(index: Int) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController

        vc!.post = postsArray[index]
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}

// MARK: - SearchBar
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

