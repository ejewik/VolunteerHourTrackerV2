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
    
    
    
    //static var totalHours : Int16 = 0
    //var initialHours : Int16 = 0
    
    var entry: Entry?
    
    var datePicker : UIDatePicker = UIDatePicker()
    var timeToPicker : UIDatePicker = UIDatePicker()
    var timeFromPicker : UIDatePicker = UIDatePicker()
    
   
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeFromTextField: UITextField!
    @IBOutlet weak var timeToTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var clubTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        addBorder( textField: titleTextField)
        addBorder( textField: clubTextField)
        descriptionTextView!.layer.borderWidth = 1
        descriptionTextView!.layer.borderColor = UIColor.darkGray.cgColor
        
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.clipsToBounds = true
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(CreateEntryViewController.dateChanged(datePicker:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        
        timeFromPicker = UIDatePicker()
        timeFromPicker.datePickerMode = .time
        timeFromPicker.addTarget(self, action: #selector(CreateEntryViewController.timeFromChanged(datePicker:)), for: .valueChanged)
        timeFromTextField.inputView = timeFromPicker
        
        timeToPicker = UIDatePicker()
        timeToPicker.datePickerMode = .time
        timeToPicker.addTarget(self, action: #selector(CreateEntryViewController.timeToChanged(datePicker:)), for: .valueChanged)
        timeToTextField.inputView = timeToPicker
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
            
            timeToTextField.text = entry.timeTo?.convertTimeToString()
            timeFromTextField.text = entry.timeFrom?.convertTimeToString()
            dateTextField.text = entry.date?.convertToString()
            
            
        } else {
        
       descriptionTextView.text = ""
        titleTextField.text = ""
            clubTextField.text = ""
            timeToPicker.date = Date()
            timeFromPicker.date = Date()
            datePicker.date = Date()
            
            timeToTextField.text = ""
            timeFromTextField.text = ""
            dateTextField.text = ""
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
            
            if (entry?.timeFrom!)! < (entry?.timeTo!)! {
            var interval = DateInterval(start: (entry?.timeFrom!)!, end: (entry?.timeTo!)!)
            let hours = interval.duration / 3600.0
            entry?.hourCount = Int16(hours)
                
                let formatter = DateComponentsFormatter()
                formatter.unitsStyle = .full
                formatter.allowedUnits = [.month, .day, .hour, .minute, .second]
                formatter.maximumUnitCount = 2
                let string = formatter.string(from: (entry?.timeFrom!)!, to: (entry?.timeTo!)!)
                entry?.stringHours = string ?? ""
            
            }
            else {
                print("error - reverse interval")
            }
            
            //CreateEntryViewController.totalHours += (entry?.hourCount)!
            
            
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
                
                let formatter = DateComponentsFormatter()
                formatter.unitsStyle = .full
                formatter.allowedUnits = [.month, .day, .hour, .minute, .second]
                formatter.maximumUnitCount = 2
                let string = formatter.string(from: entry.timeFrom!, to: entry.timeTo!)
            entry.stringHours = string ?? ""
                
                //initialHours = entry.hourCount
                
                //CreateEntryViewController.totalHours += entry.hourCount
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
    @IBAction func datePickerTapped(_ sender: UIDatePicker) {
       // timeFromPicker.inputView
    }
    
    func addBorder( textField: UITextField ) {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
        
    }
    
    @objc func timeToChanged(datePicker: UIDatePicker) {
        timeToTextField.text = timeToPicker.date.convertTimeToString()
    }
    
    @objc func timeFromChanged(datePicker: UIDatePicker) {
        timeFromTextField.text = timeFromPicker.date.convertTimeToString()
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        dateTextField.text = datePicker.date.convertToString()
    }
}




