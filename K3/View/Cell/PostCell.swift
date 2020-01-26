//
//  TableViewCell.swift
//  K3
//
//  Created by Timur Koshevoy on 23.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var blogNameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesLabelConst: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    // MARK: - Properties
    var buttonTappedAction: ((UITableViewCell?) -> Void)?
    
    // MARK: - XIB lyfecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tumblrGray = UIColor.init(displayP3Red: 185.0/255.0, green: 194.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        
        notesLabel.textColor = tumblrGray
        tagsLabel.textColor = tumblrGray
        notesLabelConst.textColor = tumblrGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    // MARK: - Functions
    func calculateHeight(post: Post) -> CGFloat{
        
        let screenWidth = self.frame.width
        let imageWidth = CGFloat.init(post.images[0].width)
        let imageHeight = CGFloat.init(post.images[0].height)
        
        var imageResized = imageHeight
        
        let noImage = CGFloat.init(100.0)
        
        if imageResized != noImage {
            imageResized = imageHeight * screenWidth / imageWidth
        } else {
            self.postImageView.contentMode = .scaleAspectFit
            self.postImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 100)
        }
        
        let a = self.blogNameLabel.frame.height + imageResized + self.summaryLabel.frame.height
        let b = self.tagsLabel.frame.height + self.notesLabel.frame.height + 30.0
        
        let height = a + b
        
        return height
    }
    
    func processFromPost(post: Post) {
        
        let imageURL = URL(string: post.images[0].url)
        
        self.postImageView!.sd_setImage(with: imageURL, completed: { (image, error, cache, url) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        })
        
        var buttonTitle = "Read"
        if post.images.count > 1 {
            buttonTitle = buttonTitle + "(+\(post.images.count - 1))"
            self.readButton.setTitle(buttonTitle, for: .normal)
            self.readButton.setTitle(buttonTitle, for: .highlighted)
        } else {
            self.readButton.setTitle(buttonTitle, for: .normal)
            self.readButton.setTitle(buttonTitle, for: .highlighted)
        }
        
        self.summaryLabel.text = post.summary
        self.blogNameLabel.text = post.blogName
        self.tagsLabel.text = post.tags.map { tag in
            return "#\(tag)"
        }.joined(separator: " ")
        self.notesLabel.text = String(post.notes)
    }
    
    // MARK: - Actions
    @IBAction func buttonTappedAction(_ sender: Any) {
        buttonTappedAction?(self)
    }
    
}

