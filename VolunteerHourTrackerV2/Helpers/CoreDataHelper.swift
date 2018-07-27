//
//  CoreDataHelper.swift
//  VolunteerHourTrackerV2
//
//  Created by Emily Jewik on 7/25/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static let donationContext: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newEntry() -> Entry {
        let entry = NSEntityDescription.insertNewObject(forEntityName: "Entry", into: context) as! Entry
        
        return entry
    }
    
    static func newDonation() -> Donation {
        let donation = NSEntityDescription.insertNewObject(forEntityName: "Donation", into: donationContext) as! Donation
        
        return donation
    }
    
    static func saveEntry() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func saveDonation() { //will this work?????
        do {
            try donationContext.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(entry: Entry) {
        context.delete(entry)
        
        saveEntry()
    }
    
    static func delete(donation: Donation) {
        donationContext.delete(donation)
        
        saveDonation()
    }
    
    static func retrieveEntries() -> [Entry] {
        do {
            let fetchRequest = NSFetchRequest<Entry>(entityName: "Entry")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
    static func retrieveDonations() -> [Donation] {
        do {
            let fetchRequest = NSFetchRequest<Donation>(entityName: "Donation")
            let results = try donationContext.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
}
