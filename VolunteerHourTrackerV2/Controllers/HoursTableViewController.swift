//
//  HoursTableViewController.swift
//  VolunteerHourTrackerV2
//
//  Created by Emily Jewik on 7/23/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import Foundation
import UIKit



class HoursTableViewController : UITableViewController  {
   // func needHours(controller: CreateEntryViewController, hours: Int16) {
        //
   // }
    
    
    
    
    //var totalHours : Int = 0
    
    var entries = [Entry]() {
        didSet {
            tableView.reloadData()
            
            var totalHours : Int = 0
            for entry in entries {
                totalHours += Int(entry.hourCount)
            }
            self.title = "Total hours: \(String(totalHours))"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         entries = CoreDataHelper.retrieveEntries()
        
       // self.title = "Total hours: \(String(CreateEntryViewController.totalHours))"
        
    }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return entries.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourTableViewCell", for: indexPath) as! HourTableViewCell
            let entry = entries[indexPath.row]
            
           
            cell.eventLabel.text = entry.eventTitle
            
            cell.clubLabel.text = entry.club
            
            //cell..text = entry.content
            cell.dateLabel.text = entry.date?.convertToString() ?? "unknown"
            cell.hourLabel.text = String(entry.hourCount)
            

          
            
            
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
        entries = CoreDataHelper.retrieveEntries()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entryToDelete = entries[indexPath.row]
            CoreDataHelper.delete(entry: entryToDelete)
            
            entries = CoreDataHelper.retrieveEntries()
        }
    }
    
    
}
