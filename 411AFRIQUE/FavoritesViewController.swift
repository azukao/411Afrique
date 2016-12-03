//
//  FavoritesViewController.swift
//  411AFRIQUE
//
//  Created by Azuka Omesiete on 11/21/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoritesViewController: UITableViewController {
    var PlaceArray = NSArray()
    var tableSource: FavoriteTableview?
    var places = [NSManagedObject]()
    
    @IBOutlet var tableViewer: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favorite Locations"
          tableViewer.reloadData()

    }
    
    @IBAction func refresh(sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Results")
        fetchRequest.predicate = NSPredicate(format: "isFavorite = 1")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            places = results as! [NSManagedObject]
            PlaceArray = places as NSArray
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        DispatchQueue.main.async  {
            self.tableSource = FavoriteTableview()
            self.tableSource?.arrTableData = self.PlaceArray
              self.tableViewer.reloadData()
            self.tableViewer.dataSource = self.tableSource
            self.tableViewer.delegate = self.tableSource
        }
    }
}
