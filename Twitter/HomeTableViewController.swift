//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Boris Ofon on 9/26/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets) , for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }

    
    @objc func loadTweets(){
        numberOfTweets = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print(Error)
        })
    }
    
    func loadMoreTweets() {
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets += 20
        
        let myParams = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print(Error)
        })
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"]  as? String
        cell.tweetContentLabel.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData =  data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    
    @IBAction func LoginButtonPressed(_ sender: UIBarButtonItem) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "userLogggedIn" )
        self.dismiss(animated: true)
    }
    
}
