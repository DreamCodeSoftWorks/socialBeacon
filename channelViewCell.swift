//
//  channelViewCell.swift
//  socialBeacon
//
//  Created by Omar Skalli on 2/5/16.
//  Copyright © 2016 cmu. All rights reserved.
//

import UIKit

class channelViewCell : UITableViewCell {
    
    @IBOutlet weak var streamLabel: UIButton!
    @IBOutlet weak var channelLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
