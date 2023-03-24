//
//  MyTableViewCell.swift
//  ApiIntegration
//
//  Created by Sumayya Siddiqui on 23/03/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
