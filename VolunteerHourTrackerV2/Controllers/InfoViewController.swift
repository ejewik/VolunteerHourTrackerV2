//
//  InfoViewController.swift
//  VolunteerHourTrackerV2
//
//  Created by Emily Jewik on 8/3/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var licenseTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        licenseTextView.allowsEditingTextAttributes = false
        licenseTextView.isEditable = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   
}
