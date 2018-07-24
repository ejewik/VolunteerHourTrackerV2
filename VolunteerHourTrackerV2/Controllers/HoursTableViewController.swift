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
    
    var entries = [Entry]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return entries.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourTableViewCell", for: indexPath) as! HourTableViewCell
             //let cell2 = tableView.dequeueReusableCell(withIdentifier: "HourTableViewCell", for: indexPath) as! HourTableViewCell
            //cell.textLabel?.text = "Cell Row: \(indexPath.row) Section: \(indexPath.section)"
            let entry = entries[indexPath.row]
            
            cell.eventLabel.text = entry.eventTitle
            cell.hourLabel.text = entry.hourCount
            cell.clubLabel.text = entry.club
           // cell.dateLabel.text = "date"
            
            //cell.eventLabel.text = "title"
            //cell.hourLabel.text = "hours"
            //cell.clubLabel.text = "club"
            
            
            return cell
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayEntry":
           
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let entry = entries[indexPath.row]
            
            let destination = segue.destination as! CreateEntryViewController
            
            destination.entry = entry
            
        case "addEntry":
            print("create entry button tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }

    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
    
}
