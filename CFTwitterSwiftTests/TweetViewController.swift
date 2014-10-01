//
//  TweetViewController.swift
//  CFTwitterSwift
//
//  Created by Bradley Johnson on 9/16/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    var user : User?
    var selectedTweetID : String!
    var selectedReplyUserID : String?
    var selectedUserID : String!
    
    var networkController : TwitterNetworkController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch tweet info for specific tweet using the tweetID
        self.networkController.fetchTweetFromID(self.selectedTweetID, completionHandler: { (errorDescription, tweet) -> (Void) in
            if tweet != nil {
                //gotta get back to the main queue since we are making interface changes
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweetTextLabel.text = tweet!.text
                    self.retweetsLabel.text = "Retweets: \(tweet!.retweetCount)"
                    self.favoritesLabel.text = "Favorites: \(tweet!.favoritesCount)"
                })
            }
        })
        //if its a reply to a tweet, we are going to retrieve the user info for the person who wrote the original tweet, if not we will fetch the user who tweeted this tweet
        var userID : String
        if self.selectedReplyUserID != nil {
            userID = self.selectedReplyUserID!
        } else {
            userID = self.selectedUserID
        }
        
        //fetch user info for userID
        self.networkController.fetchUserForUserID(userID, completionHandler: { (errorDescription, user) -> (Void) in
            if user != nil {
                self.user = user
                self.networkController.fetchUserImageForURL(user!.profileImageURL, completionHandler: { (image) -> (Void) in
                    self.userButton.setBackgroundImage(image, forState: UIControlState.Normal)
                    self.user!.profileImage = image
                    })
            }
        })
    }

    @IBAction func userButtonPressed(sender: AnyObject) {
        let userTimeLineVC = self.storyboard!.instantiateViewControllerWithIdentifier("UserTimeLine") as UserTimeLineViewController
        //userTimeLineVC.userID = self.selectedTweet.userID
        userTimeLineVC.user = self.user
        userTimeLineVC.networkController = self.networkController
        self.navigationController!.pushViewController(userTimeLineVC, animated: true)
    }
}
