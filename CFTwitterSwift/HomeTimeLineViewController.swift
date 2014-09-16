//
//  HomeTimeLineViewController.swift
//  CFTwitterSwift
//
//  Created by Bradley Johnson on 9/16/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit
import Social
import Accounts

class HomeTimeLineViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tweets = [Tweet]()
    var networkController = TwitterNetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        //self.fetchMochTweets()
        self.networkController.fetchUsersHomeTimeLineWithCompletionHandler { (errorDescription, tweets) -> (Void) in
            if errorDescription != nil {
                //oh crap
            } else {
                self.tweets = tweets!
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func fetchMochTweets () {
        let path = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") as String?
        if path != nil {
            var error : NSError?
            let JSONData = NSData(contentsOfFile: path!)
            if let JSONArray = NSJSONSerialization.JSONObjectWithData(JSONData, options: nil, error: &error) as? NSArray {
                
                for JSONObject in JSONArray {
                    
                    if let JSONDictionary = JSONObject as? NSDictionary {
                        
                        let tweet = Tweet(jsonDictionary: JSONDictionary)
                        self.tweets.append(tweet)
                    }
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Tweet" {
            
            let indexPath = self.tableView.indexPathForSelectedRow() as NSIndexPath?
            let tweet = self.tweets[indexPath!.row]
            let destinationViewController = segue.destinationViewController as TweetViewController
            destinationViewController.selectedTweet = tweet
            destinationViewController.networkController = self.networkController
        }
    }
    
    //MARK: UITableViewDataSourceDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as TweetCell
        cell.setupCell(self.tweets[indexPath.row])
        return cell
    }
    
    

}
