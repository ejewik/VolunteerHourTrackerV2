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
    
    
    
    @IBOutlet weak var shareHoursButton: UIButton!
    @IBOutlet weak var shareDonationsButton: UIButton!
    
    //weak var delegate : updateDelegate?
    var tableView: UITableView = UITableView(frame: CGRect() )
    let pdfData2 : Data = Data()
    
    let textAttributes:[NSAttributedStringKey:Any] = [
        
        NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: "PingFang HK", size: 20)!,
        NSAttributedStringKey(rawValue: NSAttributedStringKey.strokeWidth.rawValue): 0 ]
    
    
    var entriesArray = [Entry]() {
        didSet {
            
            // observer that knows when the arrays gets new data
            // reload data
            //CoreDataHelper.retrieveEntries()
            tableView.reloadData()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareHoursButton.layer.cornerRadius = 20.0
        shareDonationsButton.layer.cornerRadius = 20.0
    }
    
    let tableDef = TableDefinition(alignments: [ .center, .center, .center, .center], //alignment not working???
                                   columnWidths: [150, 150, 110, 110],
                                   fonts: [UIFont.systemFont(ofSize: 12),
                                           UIFont.systemFont(ofSize: 12),
                                           UIFont.systemFont(ofSize: 12),
                                           UIFont.systemFont(ofSize: 12)],
                                   
                                   textColors: [UIColor.black,
                                                UIColor.black, UIColor.black, UIColor.black])
    
    let shortTableDef = TableDefinition(alignments: [.center, .center, .center, .center], //alignment not working???
        columnWidths: [150, 150, 110, 110],
        fonts: [UIFont.boldSystemFont(ofSize: 15),
                UIFont.boldSystemFont(ofSize: 15),
                UIFont.boldSystemFont(ofSize: 15),
                UIFont.boldSystemFont(ofSize: 15)],
        
        textColors: [UIColor.black,
                     UIColor.black, UIColor.black, UIColor.black])
    
    
    
    let donationTableDef = TableDefinition(alignments: [ .center, .center, .center, .center, .center], //alignment not working???
        columnWidths: [150, 150, 80, 80, 80],
        fonts: [UIFont.systemFont(ofSize: 12),
                UIFont.systemFont(ofSize: 12),
                UIFont.systemFont(ofSize: 12),
                UIFont.systemFont(ofSize: 12),
                UIFont.systemFont(ofSize: 12)],
        
        textColors: [UIColor.black,
                     UIColor.black, UIColor.black, UIColor.black, UIColor.black ])
    
    let donationShortTableDef = TableDefinition(alignments: [.center, .center, .center, .center, .center], //alignment not working???
        columnWidths: [150, 150, 80, 80, 80],
        fonts: [UIFont.boldSystemFont(ofSize: 15),
                UIFont.boldSystemFont(ofSize: 15),
                UIFont.boldSystemFont(ofSize: 15),
                UIFont.boldSystemFont(ofSize: 15),
            UIFont.boldSystemFont(ofSize: 15)],
        
        textColors: [UIColor.black,
                     UIColor.black, UIColor.black, UIColor.black, UIColor.black])
    
    
    
    
    
    

    
    @IBAction func shareDataButtonTapped(_ sender: Any) {
        
        
        let A4paperSize = CGSize(width: 595, height: 842) // need animated font on nav bar
        let pdf = SimplePDF(pageSize: A4paperSize)
        
        let string = NSAttributedString(string: "Hour Table" , attributes: textAttributes)
            
//             titleLabel.attributedText = NSAttributedString(string: "  Total Dollars: \(doubleToString(doubleValue: totalDollars)) Total Items: \(totalItems)", attributes: textAttributes)
        pdf.addText(string.string)
        pdf.addLineSeparator()
        pdf.addLineSpace( 20.0 )
        
        let keyArray = [["              Title", "               Club", "         Hours", "          Date"]] // 4 tabs / 3 tabs
        pdf.addTable(1, columnCount: 4, rowHeight: 76.0, tableLineWidth: 0.5, tableDefinition: shortTableDef, dataArray: keyArray)
        //pdf.addTable(1, columnCount: 4, rowHeight: 76.0, columnWidth: 140.0, tableLineWidth: 1.0, font: UIFont.systemFont(ofSize: 20.0), dataArray: keyArray)
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
        //CoreDataHelper.retrieveEntries()
        tableView.reloadData()
        //         self.delegate?.didUpdate()(self)
        //
        //        let updates = Updates()
        //        updates.delegate = self
        
        if entriesArray.count > 0 {
        
        var dataArray = Array(repeating: Array(repeating: "", count: 4), count: entriesArray.count)
        //crashes when no entries at all
        
        for col in 0...0 {
            for row in 0...entriesArray.count - 1{
                dataArray[row][col] = " \(entriesArray[row].eventTitle!)"
            }
        }
        
        for col in 1...1 {
            for row in 0...entriesArray.count - 1{
                dataArray[row][col] = " \(entriesArray[row].club!)"
            }
        }
            
            for col in 2...2 {
                for row in 0...entriesArray.count - 1 {
                    dataArray[row][col] =
                    " \(entriesArray[row].stringHours!)"
                }
            }
            
            for col in 3...3 {
                for row in 0...entriesArray.count - 1 {
                    dataArray[row][col] = " \((entriesArray[row].date?.convertToString())!)"
                }
            }
        //dataArray is fine
        
        for entry in entriesArray {
            print("entry: \(String(describing: entry.eventTitle))")
        }
        //let dataArray = [["test1","test2"],["test3","test4"]]
        
        var tableCount = 0
        //var sprites = [SKSpriteNode?](count: 64, repeatedValue: nil)
        
        var oneTableArray = Array(repeating: Array(repeating: "", count: 4), count: 8)
        var tableRow = 0
        repeat {
        
        if dataArray.count > tableCount + 8 {
//            for i in tableCount...dataArray.count - 1 {
//                oneTableArray[tableCount] = dataArray[]
//            }
            
            for col in 0...0 {
                for row in tableCount...tableCount+8 - 1{
                    oneTableArray[tableRow][col] = dataArray[row][col]
                    tableRow += 1 //actually why is this working haha
                    if tableRow == 8 {
                        tableRow = 0
                    }
                }
            }
            
            for col in 1...1 {
                for row in tableCount...tableCount+8 - 1{
                    oneTableArray[tableRow][col] = dataArray[row][col]
                    tableRow += 1
                    if tableRow == 8 {
                        tableRow = 0
                    }
                }
            }
                
                for col in 2...2 {
                    for row in tableCount...tableCount+8 - 1 {
                        oneTableArray[tableRow][col] = dataArray[row][col]
                        tableRow += 1
                        if tableRow == 8 {
                            tableRow = 0
                        }
                    }
                }
                
                for col in 3...3 {
                    for row in tableCount...tableCount+8 - 1 {
                        oneTableArray[tableRow][col] = dataArray[row][col]
                        tableRow += 1
                        if tableRow == 8 {
                            tableRow = 0
                        }
                    }
                }
            
           
            
           
            
            pdf.addTable(8, columnCount: 4, rowHeight: 76.0, tableLineWidth: 0.5, tableDefinition: tableDef, dataArray: oneTableArray)
            
            tableCount += 8
            
                pdf.beginNewPage()
            }
//        } else if tableCount > 9 {
//
//            pdf.addTable(entriesArray.count - tableCount, columnCount: 4, rowHeight: 76.0, columnWidth: 136.0, tableLineWidth: 1.0, font: UIFont.systemFont(ofSize: 20.0), dataArray: oneTableArray)
//
//        }  else {
//            pdf.addTable(entriesArray.count , columnCount: 4, rowHeight: 76.0, columnWidth: 136.0, tableLineWidth: 1.0, font: UIFont.systemFont(ofSize: 20.0), dataArray: dataArray)
//            }
            
            
        } while entriesArray.count - tableCount > 8
        
        
        // 25 entries rn so 18 should appear 2 pages 1 half pg
        var row2 = 0
        
        for col in 0...0 {
            row2 = 0
            for row in tableCount...entriesArray.count - 1{
                
                oneTableArray[row2][col] = dataArray[row][col] // row is out of bounds
                row2 += 1
                
                
            }
        }
        
        for col in 1...1 {
            row2 = 0
            for row in tableCount...entriesArray.count - 1{
                
                oneTableArray[row2][col] = dataArray[row][col]
                row2 += 1
                
            }
        }
        
        for col in 2...2 {
            row2 = 0
            for row in tableCount...entriesArray.count - 1 {
                
                oneTableArray[row2][col] = dataArray[row][col]
                row2 += 1
               
            }
        }
        
        for col in 3...3 {
            row2 = 0
            for row in tableCount...entriesArray.count - 1 {
                
                oneTableArray[row2][col] = dataArray[row][col]
                row2 += 1
                
            }
        
        }
        
        
            pdf.addTable(row2, columnCount: 4, rowHeight: 76.0, tableLineWidth: 1.0, tableDefinition: tableDef,  dataArray: oneTableArray)
        }
        
        let pdfData = pdf.generatePDFdata()
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let fileURL = documentsDirectory.appendingPathComponent("Hours.pdf")
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
            let fileURL = documentsDirectory.appendingPathComponent("Hours.pdf")
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
    
    
    @IBAction func unwindFromInfo(_ segue: UIStoryboardSegue) {
        
    }
    
    //MARK: - donations pdf
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    var donationsArray = [Donation]() {
        didSet {
            
            // observer that knows when the arrays gets new data
            // reload data
            //CoreDataHelper.retrieveDonations()
            tableView.reloadData()
            
        }
        
    }
    
    
    @IBAction func donationsButtonTapped(_ sender: UIButton) {
        
        
        let A4paperSize2 = CGSize(width: 595, height: 842)
        let pdf = SimplePDF(pageSize: A4paperSize2)
        
      
        
        let string = NSAttributedString(string: "Donation Table" , attributes: textAttributes)
        
        //             titleLabel.attributedText = NSAttributedString(string: "  Total Dollars: \(doubleToString(doubleValue: totalDollars)) Total Items: \(totalItems)", attributes: textAttributes)
        pdf.addText(string.string)
        pdf.addLineSeparator()
        pdf.addLineSpace( 20.0 )
        
        let keyArray = [["            Title", "             Club", "     Dollars", "      Items", "      Date"]] // 4 tabs / 3 tabs
        pdf.addTable(1, columnCount: 5, rowHeight: 76.0, tableLineWidth: 0.5, tableDefinition: donationShortTableDef, dataArray: keyArray)
        
        //CoreDataHelper.retrieveDonations()
        tableView.reloadData()
       
        
        if donationsArray.count > 0 {
            
            var dataArray = Array(repeating: Array(repeating: "", count: 5), count: donationsArray.count)
            //crashes when no entries at all
            
            for col in 0...0 {
                for row in 0...donationsArray.count - 1{
                    dataArray[row][col] = " \(donationsArray[row].eventTitle! )"
                }
            }
            
            for col in 1...1 {
                for row in 0...donationsArray.count - 1{
                    dataArray[row][col] = " \(donationsArray[row].club!)"
                }
            }
            
            
            for col in 2...2 {
                for row in 0...donationsArray.count - 1 {
                    dataArray[row][col] = " \(String(donationsArray[row].dollarCount))"
                }
            }
            
            for col in 3...3 {
                for row in 0...donationsArray.count - 1 {
                    dataArray[row][col] = " \(String(donationsArray[row].itemCount))"
                }
            }
            
            for col in 4...4 {
                for row in 0...donationsArray.count - 1 {
                    dataArray[row][col] = " \((donationsArray[row].date?.convertToString())!)"
                }
            }
            //dataArray is fine
            
        
            var tableCount = 0
           
            
            var oneTableArray = Array(repeating: Array(repeating: "", count: 5), count: 8)
            var tableRow = 0
            repeat {
                
                if dataArray.count > tableCount + 8 {
                   
                    for col in 0...0 {
                        for row in tableCount...tableCount+8 - 1{
                            oneTableArray[tableRow][col] = dataArray[row][col]
                            tableRow += 1
                            if tableRow == 8 {
                                tableRow = 0
                            }
                        }
                    }
                    
                    for col in 1...1 {
                        for row in tableCount...tableCount+8 - 1{
                            oneTableArray[tableRow][col] = dataArray[row][col]
                            tableRow += 1
                            if tableRow == 8 {
                                tableRow = 0
                            }
                        }
                    }
                    
                    for col in 2...2 {
                        for row in tableCount...tableCount+8 - 1 {
                            oneTableArray[tableRow][col] = dataArray[row][col]
                            tableRow += 1
                            if tableRow == 8 {
                                tableRow = 0
                            }
                        }
                    }
                    
                    for col in 3...3 {
                        for row in tableCount...tableCount+8 - 1 {
                            oneTableArray[tableRow][col] = dataArray[row][col]
                            tableRow += 1
                            if tableRow == 8 {
                                tableRow = 0
                            }
                        }
                    }
                    for col in 4...4 {
                        for row in tableCount...tableCount+8 - 1 {
                            oneTableArray[tableRow][col] = dataArray[row][col]
                            tableRow += 1
                            if tableRow == 8 {
                                tableRow = 0
                            }
                        }
                    }
                    
                    pdf.addTable(8, columnCount: 5, rowHeight: 76.0, tableLineWidth: 0.5, tableDefinition: donationTableDef, dataArray: oneTableArray)
                    
//                    pdf.addTable(8, columnCount: 5, rowHeight: 76.0, columnWidth: 136.0, tableLineWidth: 1.0, font: UIFont.systemFont(ofSize: 20.0), dataArray: oneTableArray)
                    
                    tableCount += 8
                    
                    pdf.beginNewPage()
                }
                
                
                
            } while donationsArray.count - tableCount > 8
            
            var row2 = 0
            
            for col in 0...0 {
                row2 = 0
                for row in tableCount...donationsArray.count - 1{
                    
                    oneTableArray[row2][col] = dataArray[row][col] // row is out of bounds
                    row2 += 1
                    
                    
                }
            }
            
            for col in 1...1 {
                row2 = 0
                for row in tableCount...donationsArray.count - 1{
                    
                    oneTableArray[row2][col] = dataArray[row][col]
                    row2 += 1
                    
                }
            }
            
            for col in 2...2 {
                row2 = 0
                for row in tableCount...donationsArray.count - 1 {
                    
                    oneTableArray[row2][col] = dataArray[row][col]
                    row2 += 1
                    
                }
            }
            
            for col in 3...3 {
                row2 = 0
                for row in tableCount...donationsArray.count - 1 {
                    
                    oneTableArray[row2][col] = dataArray[row][col]
                    row2 += 1
                    
                }
                
            }
            for col in 4...4 {
                row2 = 0
                for row in tableCount...donationsArray.count - 1 {
                    
                    oneTableArray[row2][col] = dataArray[row][col]
                    row2 += 1
                    
                }
                
            }
            
            
            //pdf.addTable(row2, columnCount: 5, rowHeight: 76.0, columnWidth: 136.0, tableLineWidth: 1.0, font: UIFont.systemFont(ofSize: 20.0), dataArray: oneTableArray)
            
            pdf.addTable(row2, columnCount: 5, rowHeight: 76.0, tableLineWidth: 0.5, tableDefinition: donationTableDef, dataArray: oneTableArray)
        }
        
        let pdfData = pdf.generatePDFdata()
        
        
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let fileURL = documentsDirectory.appendingPathComponent("Donations.pdf")
            print("path is \(fileURL)")
            do {
                try pdfData.write( to: fileURL , options: .atomic)
            }
            catch {
                print("catch error",error.localizedDescription)
            }
        }
        
        
        
        
        
       
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let fileURL = documentsDirectory.appendingPathComponent("Donations.pdf")
            print("url: \(fileURL)")
          
            let controller = UIDocumentInteractionController(url: fileURL)
           
            controller.delegate = self
            controller.presentPreview(animated: true)
     
        
        
        
        
    }
    
    
    
}

}



   

