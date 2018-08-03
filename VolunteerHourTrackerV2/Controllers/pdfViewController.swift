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

class pdfViewController : UIViewController, UIDocumentInteractionControllerDelegate  {
    
    
    
    @IBOutlet weak var textField: UITextField!
    //weak var delegate : updateDelegate?
    var tableView: UITableView = UITableView(frame: CGRect() )
    let pdfData2 : Data = Data()
    var entriesArray = [Entry]() {
        didSet {
            
            // observer that knows when the arrays gets new data
            // reload data
            CoreDataHelper.retrieveEntries()
            tableView.reloadData()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let A4paperSize = CGSize(width: 595, height: 842)
//        let pdf = SimplePDF(pageSize: A4paperSize)
//
//        pdf.addText("Hello World!")
//        // or
//        // pdf.addText("Hello World!", font: myFont, textColor: myTextColor)
//
//        //pdf.addImage( anImage )
//        pdf.addText("Testing testing")
//
//        // CoreDataHelper should retrieve entries and populate the entries array
//
//
//       // var dataArray = String[entriesArray.count][4]
//       // var dataArray = [[String]](repeating: [String](repeating: 0, count: entriesArray.count), count: 4)
//       // var dataArray = [[String]](repeating: [String](repeating: 0, count: 5), count: 4)
//
//        // Before you can write this arry to the file
//        // First retrieve and reload data to the array
//        // Then when you write to file, it should be up to date
//        //is it only writing to file once...?
//        CoreDataHelper.retrieveEntries()
//        tableView.reloadData()
////         self.delegate?.didUpdate()(self)
////
////        let updates = Updates()
////        updates.delegate = self
//
//        var dataArray = Array(repeating: Array(repeating: "", count: 4), count: entriesArray.count)
//
//
//        for col in 0...0 {
//            for row in 0...entriesArray.count - 1{
//                dataArray[row][col] = entriesArray[row].eventTitle ?? ""
//            }
//        }
//
//        for col in 1...1 {
//            for row in 0...entriesArray.count - 1{
//                dataArray[row][col] = entriesArray[row].stringHours ?? ""
//            }
//
//            for col in 2...2 {
//                for row in 0...entriesArray.count - 1 {
//                    dataArray[row][col] = entriesArray[row].club!
//                }
//            }
//
//            for col in 3...3 {
//                for row in 0...entriesArray.count - 1 {
//                    dataArray[row][col] = (entriesArray[row].date?.convertToString())!
//                }
//            }
//        }
//        for entry in entriesArray {
//            print("entry: \(String(describing: entry.eventTitle))")
//        }
//        //let dataArray = [["test1","test2"],["test3","test4"]]
//        pdf.addTable(entriesArray.count, columnCount: 4, rowHeight: 50.0, columnWidth: 100.0, tableLineWidth: 1.0, font: UIFont.systemFont(ofSize: 20.0), dataArray: dataArray)
//
//        let pdfData = pdf.generatePDFdata()
//
//        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
//            let fileURL = documentsDirectory.appendingPathComponent("myDocument.pdf")
//            print("path is \(fileURL)")
//            do {
//                try pdfData.write( to: fileURL , options: .atomic)
//            }
//            catch {
//                print("catch error",error.localizedDescription)
//            }
//        }
//
//
//    }
//
    
    
    @IBAction func shareDataButtonTapped(_ sender: Any) {
        
        
        let A4paperSize = CGSize(width: 595, height: 842)
        let pdf = SimplePDF(pageSize: A4paperSize)
        
        pdf.addText("Hour table")
        // or
        // pdf.addText("Hello World!", font: myFont, textColor: myTextColor)
        
        //pdf.addImage( anImage )
        
        
        // CoreDataHelper should retrieve entries and populate the entries array
        
        
        // var dataArray = String[entriesArray.count][4]
        // var dataArray = [[String]](repeating: [String](repeating: 0, count: entriesArray.count), count: 4)
        // var dataArray = [[String]](repeating: [String](repeating: 0, count: 5), count: 4)
        
        // Before you can write this arry to the file
        // First retrieve and reload data to the array
        // Then when you write to file, it should be up to date
        //is it only writing to file once...?
        CoreDataHelper.retrieveEntries()
        tableView.reloadData()
        //         self.delegate?.didUpdate()(self)
        //
        //        let updates = Updates()
        //        updates.delegate = self
        
        var dataArray = Array(repeating: Array(repeating: "", count: 4), count: entriesArray.count)
        
        
        for col in 0...0 {
            for row in 0...entriesArray.count - 1{
                dataArray[row][col] = entriesArray[row].eventTitle ?? ""
            }
        }
        
        for col in 1...1 {
            for row in 0...entriesArray.count - 1{
                dataArray[row][col] = entriesArray[row].stringHours ?? ""
            }
            
            for col in 2...2 {
                for row in 0...entriesArray.count - 1 {
                    dataArray[row][col] = entriesArray[row].club!
                }
            }
            
            for col in 3...3 {
                for row in 0...entriesArray.count - 1 {
                    dataArray[row][col] = (entriesArray[row].date?.convertToString())!
                }
            }
        }
        for entry in entriesArray {
            print("entry: \(String(describing: entry.eventTitle))")
        }
        //let dataArray = [["test1","test2"],["test3","test4"]]
        
        var tableCount = 0
        //var sprites = [SKSpriteNode?](count: 64, repeatedValue: nil)
        
        var oneTableArray = Array(repeating: Array(repeating: "", count: 4), count: 9)
        var tableRow = 0
        repeat {
        
        if dataArray.count > tableCount + 9 {
//            for i in tableCount...dataArray.count - 1 {
//                oneTableArray[tableCount] = dataArray[]
//            }
            
            for col in 0...0 {
                for row in tableCount...tableCount+9 - 1{
                    oneTableArray[tableRow][col] = dataArray[row][col]
                    tableRow += 1
                    if tableRow == 9 {
                        tableRow = 0
                    }
                }
            }
            
            for col in 1...1 {
                for row in tableCount...tableCount+9 - 1{
                    oneTableArray[tableRow][col] = dataArray[row][col]
                    if tableRow == 9 {
                        tableRow = 0
                    }
                }
            }
                
                for col in 2...2 {
                    for row in tableCount...tableCount+9 - 1 {
                        oneTableArray[tableRow][col] = dataArray[row][col]
                        if tableRow == 9 {
                            tableRow = 0
                        }
                    }
                }
                
                for col in 3...3 {
                    for row in tableCount...tableCount+9 - 1 {
                        oneTableArray[tableRow][col] = dataArray[row][col]
                        if tableRow == 9 {
                            tableRow = 0
                        }
                    }
                }
            
                pdf.addTable(9, columnCount: 4, rowHeight: 76.0, columnWidth: 136.0, tableLineWidth: 1.0, font: UIFont.systemFont(ofSize: 20.0), dataArray: oneTableArray)
            tableCount += 9
                pdf.beginNewPage()
            }
//         else {
//             pdf.addTable(entriesArray.count, columnCount: 4, rowHeight: 76.0, columnWidth: 136.0, tableLineWidth: 1.0, font: UIFont.systemFont(ofSize: 20.0), dataArray: dataArray)
//        }
            
        } while entriesArray.count - tableCount > 9
        
        let pdfData = pdf.generatePDFdata()
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let fileURL = documentsDirectory.appendingPathComponent("myDocument.pdf")
            print("path is \(fileURL)")
            do {
                try pdfData.write( to: fileURL , options: .atomic)
            }
            catch {
                print("catch error",error.localizedDescription)
            }
        }
        
        
        
        
        
//        let activityController = UIActivityViewController(activityItems: [textField.text!],
//                                                          applicationActivities: nil)
//        present(activityController, animated: true, completion: nil)
//        let url = Bundle.main.url(forResource: "file:///Users/emilyjewik/Library/Developer/CoreSimulator/Devices/1F648723-F5E2-428A-9411-C5F01E89D745/data/Containers/Data/Application/A2364309-6D8D-45D0-8B4A-A7F15901286B/Documents/" , withExtension: nil )
        
       if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let fileURL = documentsDirectory.appendingPathComponent("myDocument.pdf")
            print("url: \(fileURL)")
    //        guard let url = Bundle.main.url(forResource: "file:///Users/emilyjewik/Library/Developer/CoreSimulator/Devices/1F648723-F5E2-428A-9411-C5F01E89D745/data/Containers/Data/Application/A2364309-6D8D-45D0-8B4A-A7F15901286B/Documents/myFile", withExtension: "pdf" ) else { return }
            let controller = UIDocumentInteractionController(url: fileURL)
            //probably did url incorrectly goddammit
            controller.delegate = self
            controller.presentPreview(animated: true)
        }
        
        
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
