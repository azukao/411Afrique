//
//  ResultsViewController.swift
//  411AFRIQUE
//
//  Created by Azuka Omesiete on 11/21/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ResultViewController: UITableViewController {
    
    var tableSource: TableSource?
    var places = [NSManagedObject]()
    var placeType = String()
    @IBOutlet var tableViewer: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Nearby \(placeType)"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Results")
        fetchRequest.predicate = NSPredicate(format: "type = %@", placeType)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            places = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        tableSource = TableSource()
        tableSource?.arrTableData = places as NSArray
        tableViewer.dataSource = tableSource
        tableViewer.delegate = tableSource
    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    @IBAction func clearTable() {
              deleteAllData(entity: "Results")
              places.removeAll()
              tableViewer.reloadData()
    }
    
    
    
}
