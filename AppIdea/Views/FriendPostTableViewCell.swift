//
//  FriendPostTableViewCell.swift
//  AppIdea
//
//  Created by Ryan Vanderhoef on 8/11/15.
//  Copyright (c) 2015 Ryan Vanderhoef. All rights reserved.
//

import UIKit
import Parse


class FriendPostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var extraInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
