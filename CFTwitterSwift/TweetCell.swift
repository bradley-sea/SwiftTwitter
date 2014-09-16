//
//  TweetCell.swift
//  CFTwitterSwift
//
//  Created by Bradley Johnson on 9/16/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(cellTweet : Tweet) {
        self.textLabel!.text = cellTweet.text
    }

}
