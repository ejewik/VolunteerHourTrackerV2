//
//  DonationViewController.swift
//  VolunteerHourTrackerV2
//
//  Created by Emily Jewik on 7/26/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import Foundation
import UIKit

class DonationViewController: UIViewController {
    
    //static var totalItems : Int16 = 0
    //static var totalDollars : Int16 = 0
    
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var donationTitleTextField: UITextField!
    
    @IBOutlet weak var itemCountTextField: UITextField!
    @IBOutlet weak var clubTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var dollarCountTextField: UITextField!
    
    var datePicker: UIDatePicker = UIDatePicker()
    

    var donation: Donation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        self.hideKeyboardWhenTappedAround()
        
//        let keyboard = CreateEntryViewController()
//        keyboard.hideKeyboardWhenTappedAround()
        addBorder(textField: donationTitleTextField)
        addBorder(textField: itemCountTextField)
        addBorder(textField: clubTextField)
        addBorder(textField: dollarCountTextField)
        descriptionTextView!.layer.borderWidth = 1
        descriptionTextView!.layer.borderColor = UIColor.darkGray.cgColor
        
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.clipsToBounds = true
        
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(DonationViewController.dateChanged(datePicker:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        
        
    }




    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
                if let donation = donation {
                    descriptionTextView.text = donation.content
                    donationTitleTextField.text = donation.eventTitle
                    clubTextField.text = donation.club
                    datePicker.date = donation.date!
                    itemCountTextField.text = String(donation.itemCount)
                    dollarCountTextField.text = String(donation.dollarCount)
        
        
                } else {
        
                    descriptionTextView.text = ""
                    donationTitleTextField.text = ""
                    clubTextField.text = ""
                    datePicker.date = Date()
                    itemCountTextField.text = ""
                    dollarCountTextField.text = ""
                }
            }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let identifier = segue.identifier,
                let destination = segue.destination as? HoursTableViewController
                else { return }
    
    
    
                switch identifier {
                case "done" where donation != nil: 
                    donation?.eventTitle = donationTitleTextField.text ?? ""
                    donation?.content = descriptionTextView.text ?? ""
                    donation?.club = clubTextField.text ?? ""
                    donation?.date = datePicker.date
                    donation?.itemCount = Int16(itemCountTextField.text!) ?? 0
                    donation?.dollarCount = Double(dollarCountTextField.text!) ?? 0.0
                    
//                    DonationViewController.totalItems += (donation?.itemCount)!
//                    DonationViewController.totalDollars += (donation?.dollarCount)!
    
                    CoreDataHelper.saveDonation()
    
    
    
                case "done" where donation == nil:
                    let donation = CoreDataHelper.newDonation()
                    donation.eventTitle = donationTitleTextField.text ?? ""
                    donation.content = descriptionTextView.text ?? ""
                    donation.club = clubTextField.text ?? ""
                    donation.date = datePicker.date
                    donation.itemCount = Int16(itemCountTextField.text!) ?? 0
                    donation.dollarCount = Double(dollarCountTextField.text!) ?? 0.0
                    
//                    DonationViewController.totalItems += donation.itemCount
//                    DonationViewController.totalDollars += donation.dollarCount
                    
                    
    
                    CoreDataHelper.saveDonation()
    
                case "cancel":
                    print("cancel button tapped")
    
                default: print("unexpected segue identifier")
                }
    

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
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        dateTextField.text = datePicker.date.convertToString()
    }
    
    
}



