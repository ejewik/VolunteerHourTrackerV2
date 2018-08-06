//
//  HoursTableViewController.swift
//  VolunteerHourTrackerV2
//
//  Created by Emily Jewik on 7/23/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import Foundation
import UIKit

class HoursTableViewController : UITableViewController   {
    func didUpdate() {
        
            self.tableView.reloadData()
        
    }
    
    @IBOutlet weak var hourDonationSegmented: UISegmentedControl!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    
    
    
    var totalHours : Int = 0
    
    var totalItems : Int = 0
    var totalDollars : Double = 0
    
    
    var donations = [Donation]() { // i think this executes whenever I retrieve donations with Core Data?
        didSet {
            
            tableView.reloadData()
            print("reloading donation data")
            
            //            var totalItems : Int = 0
            //            var totalDollars : Int = 0
            
            donations.sort(by: {$0.date! < $1.date!})
            
            
            for donation in donations {
                totalItems += Int(donation.itemCount)
                totalDollars += donation.dollarCount
            }
            
            self.navigationItem.title = "Total dollars: \(String(totalDollars)) Total items: \(String(totalItems))"
            
            totalItems = 0
            totalDollars = 0
            
            let secondTab = self.tabBarController?.viewControllers![1] as! pdfViewController
            secondTab.donationsArray = donations
            secondTab.tableView = tableView
            
            CoreDataHelper.saveDonation()
            
            
            
            
            //            var totalHours : Int = 0
            //            for donation in donations {
            //                totalHours += Int(donation.itemCount)
            //            }
            //            //self.navigationItem.title = "Total hours: \(String(totalHours))"
            //            self.parent?.title = "Total hours: \(String(totalHours))"
            //            self.tabBarItem.title = "testing"
        }
    }
    
    
    
    
    
    var entries = [Entry]() {
        didSet {
           
            tableView.reloadData()
            print("reloading entry data")
            

            //this may be why it's not reordering
            entries.sort(by: {$0.date! < $1.date!})
            
        

            
           // var totalHours : Int = 0
            for entry in entries {
                totalHours += Int(entry.hourCount)
            }
            //self.navigationItem.title = "Total hours: \(String(totalHours))"
            self.navigationItem.title = "Total hours: \(String(totalHours))"
            self.tabBarItem.title = "testing"
            
            totalHours = 0
            
            //will send entry info to pdfViewController
            
//            let secondTab = self.tabBarController?.viewControllers![1] as! pdfViewController
//            secondTab.entriesArray = entries
            
            let secondTab = self.tabBarController?.viewControllers![1] as! pdfViewController
            secondTab.entriesArray = entries
            secondTab.tableView = tableView 
            
            CoreDataHelper.saveEntry()
        }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.layer.cornerRadius = 20.0
        
        donations = CoreDataHelper.retrieveDonations()
        print("retrieving donations in viewDidLoad")
        

         entries = CoreDataHelper.retrieveEntries()
            print("retrieve entries in viewDidLoad")
            
 
        
            
 
        
        
  
        
        
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
            
            self.navigationItem.title = "Total hours: \(String(totalHours))"
            
            totalHours = 0
        
        case 1:
          totalDollars = 0
          totalItems = 0
        for donation in donations {
            totalItems += Int(donation.itemCount)
            totalDollars += donation.dollarCount
            
        }
       
          
          self.navigationItem.title = "Total dollars: \(doubleToString(doubleValue: totalDollars)) Total items: \(String(totalItems))"
            
          totalDollars = 0
          totalItems = 0
            
        default:
            print("unexpected total error")
        
        }
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        self.tableView.isEditing = !self.tableView.isEditing
        if self.tableView.isEditing == false {
        editButton.setTitle("Edit",for: .normal)
        } else {
        editButton.setTitle("Done",for: .normal)
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
            
         
            cell.dateLabel.text = entry.date?.convertToString() ?? "unknown"
            cell.hourLabel.text = entry.stringHours
            
            
            
            return cell
            
            
        case 1:
            print("donations selected")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DonationTableViewCell", for: indexPath) as! DonationTableViewCell
            
            let donation = donations[indexPath.row]
            
            
            cell.eventLabel.text = donation.eventTitle
            
            cell.clubLabel.text = donation.club
            
           
            cell.dateLabel.text = donation.date?.convertToString() ?? "unknown"
            
            cell.itemLabel.text = String(donation.itemCount)
            
            cell.dollarLabel.text = doubleToString(doubleValue: donation.dollarCount)
            
            
            
            
            
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
            print("Unexpected delete error")
            
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        switch hourDonationSegmented.selectedSegmentIndex {
            
        case 0:
        let movedObjTemp = entries[sourceIndexPath.item]
        entries.remove(at: sourceIndexPath.item)
        entries.insert(movedObjTemp, at: destinationIndexPath.item)
        case 1:
        let movedObjTemp = donations[sourceIndexPath.item]
        donations.remove(at: sourceIndexPath.item)
        donations.insert(movedObjTemp, at: destinationIndexPath.item)
            
        default:
            print("unexpected reordering error")
        }
    }
    
    
}

extension HoursTableViewController {
    func doubleToString( doubleValue : Double ) -> String {
    return String(format: "%.2f", doubleValue )
    }
}




