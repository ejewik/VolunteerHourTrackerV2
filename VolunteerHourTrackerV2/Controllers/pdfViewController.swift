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

class pdfViewController : UIViewController, UIDocumentInteractionControllerDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    let pdfData2 : Data = Data()
    
    
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
        
       
        let path = getDocumentsDirectory()
        
        print("path is \(path)")
        
        // save as a local file
        //try? pdfData.write( to: path , options: .atomic)
        
        do {
            try pdfData.write( to: path , options: .atomic)
        }
        catch {
            print("catch error",error.localizedDescription)
        }
        
        
        
    }
    
    
    @IBAction func shareDataButtonTapped(_ sender: Any) {
        
//        let activityController = UIActivityViewController(activityItems: [textField.text!],
//                                                          applicationActivities: nil)
//        present(activityController, animated: true, completion: nil)
//        let url = Bundle.main.url(forResource: "file:///Users/emilyjewik/Library/Developer/CoreSimulator/Devices/1F648723-F5E2-428A-9411-C5F01E89D745/data/Containers/Data/Application/A2364309-6D8D-45D0-8B4A-A7F15901286B/Documents/" , withExtension: nil )
        
        let url = URL(fileURLWithPath: "file:///Users/emilyjewik/Library/Developer/CoreSimulator/Devices/1F648723-F5E2-428A-9411-C5F01E89D745/data/Containers/Data/Application/A2364309-6D8D-45D0-8B4A-A7F15901286B/Documents/")
        //guard let url = Bundle.main.url(forResource: "www.example.com", withExtension: nil ) else { return }
        let controller = UIDocumentInteractionController(url: url)
        //probably did url incorrectly goddammit
        controller.delegate = self
        controller.presentPreview(animated: true)
        print("should present share...?")
        
    }
    
    //https://www.youtube.com/watch?v=Nkaoz0ctwvA
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    //https://www.hackingwithswift.com/example-code/system/how-to-find-the-users-documents-directory
    
    
}

//class ViewController: UIViewController, UIDocumentInteractionControllerDelegate {
//
//    final private let stringWithLink = "Please download this app here in App Store: https://google.com"
//
//    @IBAction func shareStringTapped(_ sender: Any) {
//        let activityController = UIActivityViewController(activityItems: [stringWithLink], applicationActivities: nil)
//
//        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
//            if completed {
//                print("completed")
//            } else {
//                print("cancled")
//            }
//        }
//        present(activityController, animated: true) {
//            print("presented")
//        }
//    }
//
//    @IBAction func shareImageTapped(_ sender: Any) {
//        guard let image = UIImage(named: "img") else { return }
//        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//
//        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
//            if completed {
//                print("completed")
//            } else {
//                print("cancled")
//            }
//        }
//        present(activityController, animated: true) {
//            print("presented")
//        }
//    }
//
//    @IBAction func sharePDFTapped(_ sender: Any) {
//        guard let url = Bundle.main.url(forResource: "img", withExtension: "pdf") else { return }
//        let controller = UIDocumentInteractionController(url: url)
//        controller.delegate = self
//        controller.presentPreview(animated: true)
//    }
//
//    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
//        return self
//    }
//
//}
