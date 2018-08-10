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
    
//
//    @IBOutlet weak var doneButton: UIButton!
//    @IBOutlet weak var dateTextField: UITextField!
//    @IBOutlet weak var timeFromTextField: UITextField!
//    @IBOutlet weak var timeToTextField: UITextField!
//    @IBOutlet weak var titleTextField: UITextField!
    
//    @IBOutlet weak var descriptionTextView: UITextView!
//    @IBOutlet weak var clubTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeFromTextField: UITextField!
    @IBOutlet weak var timeToTextField: UITextField!
    @IBOutlet weak var clubTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomLabel.isHidden = true
        topLabel.isHidden = true 
        
        descriptionTextView.isScrollEnabled = false
        //NotificationCenter.default.addObserver(self, selector: #selector(CreateEntryViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(CreateEntryViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.hideKeyboardWhenTappedAround()
        addBorder( textField: titleTextField)
        addBorder( textField: clubTextField)
        descriptionTextView!.layer.borderWidth = 0.4
        descriptionTextView!.layer.borderColor = UIColor.lightGray.cgColor
        
        descriptionTextView.layer.cornerRadius = 3
        descriptionTextView.clipsToBounds = true
        
        doneButton.layer.cornerRadius = 20.0
        
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        dateTextField.text = datePicker.date.convertToString()
        datePicker.addTarget(self, action: #selector(CreateEntryViewController.dateChanged(datePicker:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        
        timeFromPicker = UIDatePicker()
        timeFromPicker.datePickerMode = .time
        timeFromTextField.text = timeFromPicker.date.convertTimeToString()
        timeFromPicker.addTarget(self, action: #selector(CreateEntryViewController.timeFromChanged(datePicker:)), for: .valueChanged)
        timeFromTextField.inputView = timeFromPicker
        
        timeToPicker = UIDatePicker()
        timeToPicker.datePickerMode = .time
        timeToTextField.text = timeToPicker.date.convertTimeToString()
        timeToPicker.addTarget(self, action: #selector(CreateEntryViewController.timeToChanged(datePicker:)), for: .valueChanged)
        timeToTextField.inputView = timeToPicker
        
        let toolBar = UIToolbar().ToolbarPicker(mySelect: #selector(CreateEntryViewController.dismissPicker))
        
        dateTextField.inputAccessoryView = toolBar
        
        timeFromTextField.inputAccessoryView = toolBar
        
        timeToTextField.inputAccessoryView = toolBar
        
        addBorder(textField: dateTextField)
        addBorder(textField: timeFromTextField)
        addBorder(textField: timeToTextField)
        
        self.navigationItem.title = "Create"
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
            
            timeToTextField.text = timeToPicker.date.convertTimeToString()
            timeFromTextField.text = timeFromPicker.date.convertTimeToString()
            dateTextField.text = datePicker.date.convertToString()
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
                formatter.allowedUnits = [.month, .day, .hour, .minute]
                formatter.maximumUnitCount = 2
                let string = formatter.string(from: (entry?.timeFrom!)!, to: (entry?.timeTo!)!)
                
                if string?.index(of: "h") != nil {
                
                let index = string?.index(of: "h")
                let substring = string?.split(separator: "h")
                entry?.stringMinutes = "h\(String((substring?[1])!))"
                entry?.stringHours = String((substring?[0])!)
                    
                } else {
                    entry?.stringHours = "0"
                    entry?.stringMinutes = string
                }
            
            }
            else {
                print("error - reverse interval")
                entry?.stringHours = "0"
                entry?.stringMinutes = "hours"
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
            //entry.stringHours = string ?? ""
                
                if string?.index(of: "h") != nil {
                    
                let index = string?.index(of: "h")
                let substring = string?.split(separator: "h")
                entry.stringMinutes = "h\(String((substring![1])))"
                entry.stringHours = String((substring![0]))
                    
                } else {
                    entry.stringHours = "0"
                    entry.stringMinutes = string
                }
                
            }
            else
            {
                print("error - reverse interval")
                entry.stringHours = "0"
                entry.stringMinutes = "hours"
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
        let width = CGFloat(1.0)
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
    
    @objc func dismissPicker() {
        
        view.endEditing(true)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}




