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
    @IBOutlet weak var hourDonationSegmented: UISegmentedControl!
    @IBOutlet weak var addButton: UIButton!
    
    var totalHours : Int = 0
    
    var totalItems : Int = 0
    var totalDollars : Int = 0
    
    var entries = [Entry]() {
        didSet {
           
            tableView.reloadData()
            print("reloading entry data")
            
           // var totalHours : Int = 0
            for entry in entries {
                totalHours += Int(entry.hourCount)
            }
            //self.navigationItem.title = "Total hours: \(String(totalHours))"
            self.parent?.title = "Total hours: \(String(totalHours))"
            self.tabBarItem.title = "testing"
            
            totalHours = 0
        }
    }
    
    var donations = [Donation]() {
        didSet {
            
            tableView.reloadData()
            print("reloading donation data")
            
//            var totalItems : Int = 0
//            var totalDollars : Int = 0
            
           
            for donation in donations {
                totalItems += Int(donation.itemCount)
                totalDollars += Int(donation.dollarCount)
            }
            
           // self.parent?.title = "Total items: \(String(totalItems)) Total dollars: \(String(totalDollars))"
            
            totalItems = 0
            totalDollars = 0
            
            
            
            
//            var totalHours : Int = 0
//            for donation in donations {
//                totalHours += Int(donation.itemCount)
//            }
//            //self.navigationItem.title = "Total hours: \(String(totalHours))"
//            self.parent?.title = "Total hours: \(String(totalHours))"
//            self.tabBarItem.title = "testing"
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

         entries = CoreDataHelper.retrieveEntries()
            print("retrieve entries in viewDidLoad")
            
 
         donations = CoreDataHelper.retrieveDonations()
            print("retrieving donations in viewDidLoad")
            
 
       
        
  
        
        
    }
    
    
    
        
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //segue from button to view controller doesn't trigger prepare for segue
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayEntry":
           
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
          
        
            let entry = entries[indexPath.row]
            
            let destination = segue.destination as! CreateEntryViewController 
            
            destination.entry = entry
                
            print("entry display segue")
                
           
            case "displayDonation":
                
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                
                let donation = donations[indexPath.row]
                
                let destination = segue.destination as! DonationViewController //TODO: Must change to DonationViewController
                
                destination.donation = donation
                
                print("donation display segue")
        default:
            print("Unexpected display segue")
            
            
//        case "addEntry":
//            print("create entry button tapped")
//            let destination = segue.destination as! CreateEntryViewController
//
//
//        case "addDonation":
//            print("add donation button tapped")
//             let destination = segue.destination as! DonationViewController
//
//
       
            
            
       
        }
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {

        if hourDonationSegmented.selectedSegmentIndex == 0
        {
            self.performSegue(withIdentifier: "addEntry", sender: addButton)
            print("added entry")
        }
        else if hourDonationSegmented.selectedSegmentIndex == 1
        {
            self.performSegue(withIdentifier: "addDonation", sender: HoursTableViewController.self)
            print("added donation")
        }
        else
        {
            print("unexpected addEntry/addDonation error occurred")
        }
        

    }
    
    

    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        switch hourDonationSegmented.selectedSegmentIndex {
        case 0:
            entries = CoreDataHelper.retrieveEntries()
        case 1:
            donations = CoreDataHelper.retrieveDonations()
            print( "Num donations: \(donations.count)" )
            print("retrieving donations")
        
        default:
            print("unexpected unwind segue")
        
    }
    }
    
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
        
        switch hourDonationSegmented.selectedSegmentIndex {
        case 0:
              totalHours = 0
            for entry in entries {
                totalHours += Int(entry.hourCount)
            }
            
            self.parent?.title = "Total hours: \(String(totalHours))"
            
            totalHours = 0
        
        case 1:
          totalDollars = 0
          totalItems = 0
        for donation in donations {
            totalItems += Int(donation.itemCount)
            totalDollars += Int(donation.dollarCount)
            
        }
       
          
        self.parent?.title = "Total items: \(String(totalItems)) Total dollars: \(String(totalDollars))"
            
          totalDollars = 0
          totalItems = 0
            
        default:
            print("unexpected total error")
        
        }
    }
    
    
    
    
}



extension HoursTableViewController {
    
    // MARK: - TableView Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch hourDonationSegmented.selectedSegmentIndex {
        case 0:
            return entries.count
        case 1:
            return donations.count
        default:
            print("unexpected table view numberOfRowsInSection error")
            return 10
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch hourDonationSegmented.selectedSegmentIndex {
            
        case 0:
            print("hours selected")
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourTableViewCell", for: indexPath) as! HourTableViewCell
            
            let entry = entries[indexPath.row]
            
            
            cell.eventLabel.text = entry.eventTitle
            
            cell.clubLabel.text = entry.club
            
            //cell..text = entry.content
            cell.dateLabel.text = entry.date?.convertToString() ?? "unknown"
            cell.hourLabel.text = String(entry.hourCount)
            
            return cell
            
            
        case 1:
            print("donations selected")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DonationTableViewCell", for: indexPath) as! DonationTableViewCell
            
            let donation = donations[indexPath.row]
            
            
            cell.eventLabel.text = donation.eventTitle
            
            cell.clubLabel.text = donation.club
            
            //cell..text = .content
            cell.dateLabel.text = donation.date?.convertToString() ?? "unknown"
            
            cell.itemLabel.text = String(donation.itemCount)
            
            cell.dollarLabel.text = String(donation.dollarCount)
            
//            if let item = donation.itemCount {
//            cell.itemLabel.text = String(donation.itemCount)
//            }
//            else if donation.dollarCount != nil {
//                cell.itemLabel.text = String(donation.dollarCount)
//            }
//            else {
//                print("nothing in item count or dollar count")
//            }
            
            
            return cell
            
            
        default:
            print("unexpected segment control problem")
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourTableViewCell", for: indexPath) as! HourTableViewCell
            
            let entry = entries[indexPath.row]
            
            
            cell.eventLabel.text = entry.eventTitle
            
            cell.clubLabel.text = entry.club
            
            //cell..text = entry.content
            cell.dateLabel.text = entry.date?.convertToString() ?? "unknown"
            cell.hourLabel.text = String(entry.hourCount)
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch hourDonationSegmented.selectedSegmentIndex {
        case 0:
            
            if editingStyle == .delete {
                let entryToDelete = entries[indexPath.row]
                CoreDataHelper.delete(entry: entryToDelete)
                
                entries = CoreDataHelper.retrieveEntries()
            }
            
        case 1:
            
            if editingStyle == .delete {
                let donationToDelete = donations[indexPath.row]
                CoreDataHelper.delete(donation: donationToDelete)
                
                donations = CoreDataHelper.retrieveDonations()
            }
        default:
            if editingStyle == .delete {
                let entryToDelete = entries[indexPath.row]
                CoreDataHelper.delete(entry: entryToDelete)
                
                entries = CoreDataHelper.retrieveEntries()
            }
            
        }
    }
}


