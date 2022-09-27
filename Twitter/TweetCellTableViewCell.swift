//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Boris Ofon on 9/26/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    
   
    @IBOutlet var tweetContentLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
