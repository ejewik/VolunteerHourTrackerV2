//
//  pdfViewController.swift
//  VolunteerHourTrackerV2
//
//  Created by Emily Jewik on 8/1/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import Foundation
import SimplePDF
import UIKit 

class pdfViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let A4paperSize = CGSize(width: 595, height: 842)
        let pdf = SimplePDF(pageSize: A4paperSize)
        
        pdf.addText("Hello World!")
        // or
        // pdf.addText("Hello World!", font: myFont, textColor: myTextColor)
        
        //pdf.addImage( anImage )
        
        let dataArray = [["Test1", "Test2"],["Test3", "Test4"]]
        pdf.addTable(2, columnCount: 2, rowHeight: 20.0, columnWidth: 30.0, tableLineWidth: 1.0, font: UIFont.systemFont(ofSize: 5.0), dataArray: dataArray)
        
        let pdfData = pdf.generatePDFdata()
        
        // save as a local file
        try? pdfData.writeToFile(path, options: .DataWritingAtomic)
    }
    
    

    
}
