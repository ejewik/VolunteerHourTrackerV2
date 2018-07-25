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
    
    var entry: Entry?
    
   
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeToPicker: UIDatePicker!
    @IBOutlet weak var timeFromPicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let entry = entry {
        descriptionTextView.text = entry.description
        titleTextField.text = entry.eventTitle
            
        } else {
        
        descriptionTextView.text = ""
        titleTextField.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
        let destination = segue.destination as? HoursTableViewController
            else { return }
        
        switch identifier {
        case "save" where entry != nil:
            entry?.eventTitle = titleTextField.text ?? ""
            entry?.description = descriptionTextView.text ?? ""
            entry?.timeTo = Date()
            
            destination.tableView.reloadData()
            
        case "save" where entry == nil:
            let entry = Entry()
            entry.eventTitle = titleTextField.text ?? ""
            entry.description = descriptionTextView.text ?? ""
            entry.timeTo = timeToPicker.date
            entry.timeFrom = timeFromPicker.date
            var interval = DateInterval(start: entry.timeFrom, end: entry.timeTo)
            var hours = interval.duration / 3600.0
            entry.hourCount = Int(hours)
            
            destination.entries.append(entry)
            
        case "cancel":
            print("cancel button tapped")
            
        default: print("unexpected segue identifier")
        }
    }
}
