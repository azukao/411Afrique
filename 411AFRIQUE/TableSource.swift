//
//  TableSource.swift
//  411AFRIQUE
//
//  Created by Azuka Omesiete on 11/23/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TableSource:  NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var arrTableData = NSArray()
    // Mark: Table View Data Source Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    Place.placeArray = arrTableData as! [Place]
    //    return Place.placeArray.count
        return arrTableData.count
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)

        let tempArray = arrTableData[indexPath.row]//Place.placeArray[indexPath.row]//arrTableData[indexPath.row]
        let isFav = (tempArray as AnyObject).value(forKey: "isFavorite") as? Bool
        cell.textLabel?.text = (tempArray as AnyObject).value(forKey: "name") as? String//Place.placeArray[indexPath.row].name
        cell.detailTextLabel?.text = (tempArray as AnyObject).value(forKey: "address") as? String//Place.placeArray[indexPath.row].address
        if isFav! {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let tempArray = arrTableData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        
        let selctedID = (tempArray as AnyObject).value(forKey: "id") as? String
        let isFav = (tempArray as AnyObject).value(forKey: "isFavorite") as? Bool

        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Results")
        
        let predicate = NSPredicate(format:"id == %@", selctedID!)
        fetchRequest.predicate = predicate
        
        
        
        
        let results = try! managedContext.fetch(fetchRequest)       //execute(fetchRequest)
       
        let fetchData = results as! [NSManagedObject]
        
        if fetchData.count != 0 {
            
            var newFlag = true
            if isFav! {
                newFlag = false
            } else {
                newFlag = true
            }
            let resultdata = fetchData[0]
            resultdata.setValue(newFlag, forKey: "isFavorite")
            try! managedContext.save()
        }
       
        
        let fetchRequestSelect = NSFetchRequest<NSFetchRequestResult>(entityName: "Results")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequestSelect)
            
            arrTableData = results as! [NSManagedObject] as NSArray
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

        tableView.reloadData()
    }

}
