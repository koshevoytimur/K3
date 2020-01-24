//
//  TableViewCell.swift
//  K3
//
//  Created by Timur Koshevoy on 23.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: Outlets
        @IBOutlet weak var blogNameLabel: UILabel!
        @IBOutlet weak var postImageView: UIImageView!
        @IBOutlet weak var summaryLabel: UILabel!
        @IBOutlet weak var tagsLabel: UILabel!
        @IBOutlet weak var notesLabel: UILabel!
        @IBOutlet weak var notesLabelConst: UILabel!
        @IBOutlet weak var readButton: UIButton!
        
        // MARK: XIB lyfecycle
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
        
        func dynamicHight(screenWidth: CGFloat, imageWidth: CGFloat, imageHight: CGFloat) -> CGFloat{
            var imageResized = imageHight
            
            let noImage = CGFloat.init(100.0)

            if imageResized != noImage {
                imageResized = screenWidth / CGFloat(imageWidth/imageHight)
            } else {
                self.postImageView.contentMode = .scaleAspectFit
                imageResized = 100.0
            }
            
            let a = self.blogNameLabel.frame.height + imageResized + self.summaryLabel.frame.height
            let b = self.tagsLabel.frame.height + self.notesLabel.frame.height + 30.0
            
            let height = a + b
            return height
        }
    }

