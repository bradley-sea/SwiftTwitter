//
//  TweetTests.swift
//  Swift-Twitter
//
//  Created by Bradley Johnson on 9/16/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit
import XCTest

class TweetTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTweetCreation () {
        
        let path = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") as String?
        
        var tweets = [Tweet]()
        
        if path != nil {
            var error : NSError?
            let JSONData = NSData(contentsOfFile: path!)
            if let JSONArray = NSJSONSerialization.JSONObjectWithData(JSONData, options: nil, error: &error) as? NSArray {
                
                for JSONObject in JSONArray {
                    
                    if let JSONDictionary = JSONObject as? NSDictionary {
                        
                        let tweet = Tweet(jsonDictionary: JSONDictionary)
                        tweets.append(tweet)
                    }
                }
            }
            
           XCTAssertFalse(tweets.isEmpty, "test failed because tweets array was empty")
        }
    }
}
