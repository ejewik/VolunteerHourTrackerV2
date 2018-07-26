//
//  CreateEntryViewController.swift
//  VolunteerHourTrackerV2
//
//  Created by Emily Jewik on 7/23/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import Foundation
import UIKit



class CreateEntryViewController : UIViewController {
    
    
    
    static var totalHours : Int16 = 0
    var initialHours : Int16 = 0
    
    var entry: Entry?
    
    
    
   
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeToPicker: UIDatePicker!
    @IBOutlet weak var timeFromPicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var clubTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
 
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let entry = entry {
        descriptionTextView.text = entry.content
        titleTextField.text = entry.eventTitle
        clubTextField.text = entry.club
            timeToPicker.date = entry.timeTo!
            timeFromPicker.date = entry.timeFrom!
            datePicker.date = entry.date!
            
            
        } else {
        
       descriptionTextView.text = ""
        titleTextField.text = ""
            clubTextField.text = ""
            timeToPicker.date = Date()
            timeFromPicker.date = Date()
            datePicker.date = Date()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
        let destination = segue.destination as? HoursTableViewController
            else { return }
        
        switch identifier {
        case "save" where entry != nil:
            entry?.eventTitle = titleTextField.text ?? ""
            entry?.content = descriptionTextView.text ?? ""
            entry?.club = clubTextField.text ?? ""
            entry?.timeTo = timeToPicker.date
            entry?.timeFrom = timeFromPicker.date
            entry?.date = datePicker.date
            var interval = DateInterval(start: (entry?.timeFrom!)!, end: (entry?.timeTo!)!)
            let hours = interval.duration / 3600.0
            entry?.hourCount = Int16(hours)
            
           
            
            CreateEntryViewController.totalHours += (entry?.hourCount)!
            
            
            CoreDataHelper.saveEntry()
            
           
            
        case "save" where entry == nil:
            let entry = CoreDataHelper.newEntry()
            entry.eventTitle = titleTextField.text ?? ""
            entry.content = descriptionTextView.text ?? ""
            entry.club = clubTextField.text ?? ""
            entry.timeTo = timeToPicker.date
            entry.timeFrom = timeFromPicker.date
            entry.date = datePicker.date
            
            if entry.timeFrom! < entry.timeTo! {
            var interval = DateInterval(start: entry.timeFrom!, end: entry.timeTo!)
            let hours = interval.duration / 3600.0
            entry.hourCount = Int16(round(hours))
                
                initialHours = entry.hourCount
                
                CreateEntryViewController.totalHours += entry.hourCount
                //print( CreateEntryViewController.totalHours)
            }
            else
            {
                print("error - reverse interval")
            }
            
            CoreDataHelper.saveEntry()
            
        case "cancel":
            print("cancel button tapped")
            
        default: print("unexpected segue identifier")
        }
    }
}
