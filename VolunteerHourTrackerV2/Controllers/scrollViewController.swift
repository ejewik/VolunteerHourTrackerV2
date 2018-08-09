//
//  scrollViewController.swift
//  VolunteerHourTrackerV2
//
//  Created by Emily Jewik on 8/9/18.
//  Copyright © 2018 Patrick Jewik. All rights reserved.
//

import Foundation
import UIKit

class scrollViewController : UIViewController {
    
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        descriptionTextView.isScrollEnabled = false
        
    }
    
}
