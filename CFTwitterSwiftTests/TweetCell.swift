//
//  TweetCell.swift
//  CFTwitterSwift
//
//  Created by Bradley Johnson on 9/16/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.tweetTextLabel.lineBreakMode = NSLineBreakMode.ByClipping
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(cellTweet : Tweet) {

        //println(cellTweet.text)
        self.tweetTextLabel.text = cellTweet.text
        self.userLabel.text = cellTweet.userName
        self.tweetTextLabel.preferredMaxLayoutWidth = self.frame.width - 20
       self.tweetTextLabel.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.tweetTextLabel.preferredMaxLayoutWidth = self.tweetTextLabel.frame.size.width
    }

}
