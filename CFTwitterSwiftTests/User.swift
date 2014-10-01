//
//  User.swift
//  CFTwitterSwift
//
//  Created by Bradley Johnson on 9/16/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit


class User {
    
    var name : String
    var profileImageURL : String
    var location : String
    var idStr : String
    var favouritesCount : Int
    var followersCount : Int
    var profileBackgroundImageURL : String
    var verified : Bool
    var profileImage : UIImage?
    
    init (jsonDictionary : NSDictionary) {
        self.name = jsonDictionary["name"] as String
        self.profileImageURL = jsonDictionary["profile_image_url"] as String
        self.location = jsonDictionary["location"] as String
        self.idStr = jsonDictionary["id_str"] as String
        self.favouritesCount = jsonDictionary["favourites_count"] as Int
        self.followersCount = jsonDictionary["followers_count"] as Int
        self.profileBackgroundImageURL = jsonDictionary["profile_background_image_url"] as String
        self.verified = jsonDictionary["verified"] as Bool
    }
}
