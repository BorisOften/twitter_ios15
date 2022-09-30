//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Boris Ofon on 9/26/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet var tweetContentLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func likeButtonPressed(_ sender: UIButton) {
        let toBeFav = !favorited
        if (toBeFav){
            TwitterAPICaller.client?.favoritedTweet(tweetid: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print(Error.localizedDescription)
            })
        }
            else{
                TwitterAPICaller.client?.unFavoritedTweet(tweetid: self.tweetId, success: {
                    self.setFavorite(false)
                }, failure: { (Error) in
                    print(Error.localizedDescription)
                })
                
            }
    }
    
    
    @IBAction func retweetButtonPressed(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetid: tweetId, success: {
            self.retweeted = true
        }, failure: { (Error) in
            print(Error.localizedDescription)
        })
        retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)  
        
    }
    
    var favorited: Bool = false
    var tweetId:Int = -1
    var retweeted: Bool = false
    
    func setFavorite(_ isFavorite: Bool){
        favorited = isFavorite
        if(favorited){
            likeButton.setImage(UIImage(named: "favor-icon-red"),for: UIControl.State.normal)
        }else{
            likeButton.setImage(UIImage(named: "favor-icon"),for: UIControl.State.normal)
        }
    }
    func setRetweent(_ isRetweeted: Bool){
        if isRetweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
