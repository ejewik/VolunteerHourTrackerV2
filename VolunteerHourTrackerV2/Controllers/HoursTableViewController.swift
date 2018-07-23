//
//  HoursTableViewController.swift
//  VolunteerHourTrackerV2
//
//  Created by Emily Jewik on 7/23/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import Foundation
import UIKit 

class HoursTableViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourTableViewCell", for: indexPath) as! HourTableViewCell
            //cell.textLabel?.text = "Cell Row: \(indexPath.row) Section: \(indexPath.section)"
            
            cell.eventLabel.text = "event"
            cell.hourLabel.text = "hour"
            cell.clubLabel.text = "club"
            cell.dateLabel.text = "date"
            
            return cell
        }
        
        
    
}
