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
    
    
    @IBOutlet weak var donationTitleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var itemNumberPicker: UIPickerView!
    @IBOutlet weak var clubTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    

    var donation: Donation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }




    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
                if let donation = donation {
                    descriptionTextView.text = donation.content
                    donationTitleTextField.text = donation.eventTitle
                    clubTextField.text = donation.club
                    datePicker.date = donation.date!
        
        
                } else {
        
                    descriptionTextView.text = ""
                    donationTitleTextField.text = ""
                    clubTextField.text = ""
                    datePicker.date = Date()
                }
            }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let identifier = segue.identifier,
                let destination = segue.destination as? HoursTableViewController
                else { return }
    
    
    
                switch identifier {
                case "done" where donation != nil: // need set save identifier
                    donation?.eventTitle = donationTitleTextField.text ?? ""
                    donation?.content = descriptionTextView.text ?? ""
                    donation?.club = clubTextField.text ?? ""
                    donation?.date = datePicker.date
    
                    CoreDataHelper.saveDonation()
    
    
    
                case "done" where donation == nil: // why is it never hitting this
                    let donation = CoreDataHelper.newDonation() //why no donations created...?
                    donation.eventTitle = donationTitleTextField.text ?? ""
                    donation.content = descriptionTextView.text ?? ""
                    donation.club = clubTextField.text ?? ""
                    donation.date = datePicker.date
    
                    CoreDataHelper.saveDonation()
    
                case "cancel":
                    print("cancel button tapped")
    
                default: print("unexpected segue identifier")
                }
    

    }
    
    
}
