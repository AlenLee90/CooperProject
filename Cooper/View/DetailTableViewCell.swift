//
//  DetailTableViewCell.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/21.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var labelLeft: UILabel!
    
    @IBOutlet weak var labelRight: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
