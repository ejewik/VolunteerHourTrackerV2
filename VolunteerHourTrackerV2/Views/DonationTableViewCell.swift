//
//  DonationTableViewCell.swift
//  VolunteerHourTrackerV2
//
//  Created by Emily Jewik on 7/26/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import UIKit

class DonationTableViewCell: UITableViewCell {

    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var clubLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
