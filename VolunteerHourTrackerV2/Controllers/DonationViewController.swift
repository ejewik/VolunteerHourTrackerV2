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
    
    
    @IBOutlet weak var donationTitleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var itemCountTextField: UITextField!
    @IBOutlet weak var clubTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var dollarCountTextField: UITextField!
    
    
    

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
                    donation?.dollarCount = Int16(dollarCountTextField.text!) ?? 0
                    
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
                    donation.dollarCount = Int16(dollarCountTextField.text!) ?? 0
                    
//                    DonationViewController.totalItems += donation.itemCount
//                    DonationViewController.totalDollars += donation.dollarCount
                    
                    
    
                    CoreDataHelper.saveDonation()
    
                case "cancel":
                    print("cancel button tapped")
    
                default: print("unexpected segue identifier")
                }
    

    }
    
    
}
