//
//  TweetViewController.swift
//  CFTwitterSwift
//
//  Created by Bradley Johnson on 9/16/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    
    @IBOutlet weak var userImageView: UIImageView!

    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    var selectedTweet : Tweet!
    var networkController : TwitterNetworkController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkController.fetchTweetFromID(self.selectedTweet.id, completionHandler: { (errorDescription, tweet) -> (Void) in
            if tweet != nil {
                //gotta get back to the main queue since we are making interface changes
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweetTextLabel.text = tweet!.text
                    self.retweetsLabel.text = "Retweets: \(tweet!.retweetCount)"
                    self.favoritesLabel.text = "Favorites: \(tweet!.favoritesCount)"
                    var userImgURL = tweet!.profileImgURL
                    self.networkController.fetchUserImageForURL(userImgURL, completionHandler: { (image) -> (Void) in
                        self.userImageView.image = image
                    })
                })
            }
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
