//
//  KeyboardDismissExtension.swift
//  VolunteerHourTrackerV2
//
//  Created by Emily Jewik on 7/27/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import Foundation
import UIKit
import UIKit.UIGestureRecognizerSubclass


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateEntryViewController.dismissKeyboard))
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DonationViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap2.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(tap2)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
