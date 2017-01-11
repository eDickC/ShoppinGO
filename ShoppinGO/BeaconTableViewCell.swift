//
//  BeaconTableViewCell.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 11/01/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import UIKit

class BeaconTableViewCell: UITableViewCell {
    
    @IBOutlet weak var beaconName: UILabel!
    @IBOutlet weak var beaconID: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
