//
//  UserTimeLineViewController.swift
//  CFTwitterSwift
//
//  Created by Bradley Johnson on 9/16/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit

class UserTimeLineViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var networkController : TwitterNetworkController!
    var user : User!
    var tweets = [Tweet]()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
         self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.userImageView.image = self.user.profileImage
        self.userLabel.text = self.user.name
        //headerView!.contentView.backgroundColor = UIColor.redColor()
        self.networkController.fetchTweetsForUser(self.user.idStr, completionHandler: { (errorDescription, tweets) -> (Void) in
            if tweets != nil {
                self.tweets = tweets!
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.reloadData()
                })
            }
        })
        self.networkController.fetchUserImageForURL(self.user.profileBackgroundImageURL, completionHandler: { (image) -> (Void) in
            
                self.backgroundImageView.image = image
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //calling reload here because of a bug with iOS8 self sizing tableivew cells
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //calling reload here because of a bug with iOS8 self sizing tableivew cells
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as TweetCell
        let tweet = self.tweets[indexPath.row]
        cell.setupCell(tweet)
        ++cell.tag
        let tag = cell.tag
        if tweet.tweetAvatarImage != nil {
            cell.userImageView.image = tweet.tweetAvatarImage
        } else {
            self.networkController.fetchUserImageForURL(tweet.profileImgURL, completionHandler: { (image) -> (Void) in
                cell.userImageView.image = image
            })
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedTweet = self.tweets[indexPath.row]
        let tweetVC = self.storyboard!.instantiateViewControllerWithIdentifier("TWEET_VC") as TweetViewController
        
        tweetVC.selectedTweetID = "\(selectedTweet.id)"
        if selectedTweet.inReplyUserIDString != nil {
            tweetVC.selectedReplyUserID = selectedTweet.inReplyUserIDString
        }
        tweetVC.selectedUserID = "\(selectedTweet.userID)"
        tweetVC.networkController = self.networkController
        tweetVC.networkController = self.networkController
        self.navigationController?.pushViewController(tweetVC, animated: true)
    }

}
