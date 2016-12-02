//
//  GoogleClient.swift
//  411AFRIQUE
//
//  Created by Azuka Omesiete on 11/19/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class GoogleClient: NSObject {
    
    var session = URLSession.shared
    var applicationDelegate: AppDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    var places = [NSManagedObject]()
    var placeType = String()
    func findBusiness(type: String, completion: @escaping (_ success: Bool, _ errorMessage: String?) ->Void) {
        placeType = type
        var fullURL : String
        let searchRadius = 8000
       // let type = "restaurant"
        let keyword = "african"
        fullURL = "\(GoogleConstant.Keys.location)\(GoogleConstant.Parameters.LOC)\(appDelegate.latitude)\(",")\(appDelegate.longitude)\(GoogleConstant.Parameters.RADIUS)\(searchRadius)\(GoogleConstant.Parameters.TYPE)\(type)\(GoogleConstant.Parameters.KEYWORD)\(keyword)\(GoogleConstant.Parameters.API)\(GoogleConstant.Keys.API_KEY)"
        print(fullURL)
        let newUrl = NSURL(string: fullURL)!
        let request = NSMutableURLRequest(url: newUrl as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            guard error == nil else {
                print("There was an error")
                return completion(false, "There was an error")
            }
            guard let data = data else {
                print("No data was returned")
                return
            }
            
            var placeData = NSDictionary()
           
            do{
                placeData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
               // print(placeData)
            } catch {
                completion(false, "Error")
             //   Place.placeArray = placeData
            }
            let result = placeData.value(forKey: "results") as! NSArray//placeData[GoogleConstant.JSONResponseKeys.result] as! NSDictionary
            print(result)
            for i in 0..<result.count {
                if result.count > 0 {
                    let Name = (result.object(at: i) as AnyObject).value(forKey: "name") as! String
                    let Address = (result.object(at: i) as AnyObject).value(forKey: "vicinity") as! String
                    let Id  = (result.object(at: i) as AnyObject).value(forKey: "id") as! String
                    self.saveData(name: Name, address: Address, id: Id)

                }
            }
            
//            Place.placesFromArray(placeData: result as! NSArray)
            Place.placeArray = Place.placesFromArray(placeData: result)
//            Place.placeArray = [arrTemp]
            print(Place.placeArray)

            completion(true, "no error")
        }
        task.resume()
    }
    
    //create singleton to be able to call method in a different swift file that it was created in through shared instance
    class func sharedInstance() -> GoogleClient {
        struct Singleton {
            static var sharedInstance = GoogleClient()
        }
        return Singleton.sharedInstance
    }
    
    func saveData(name: String, address: String, id: String) {
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entity(forEntityName: "Results",
                                                 in:managedContext)
        
        let result = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)

        result.setValue(name, forKey: "name")
        result.setValue(address, forKey: "address")
        result.setValue(id, forKey: "id")
        result.setValue(false, forKey: "isFavorite")
        result.setValue(placeType, forKey: "type")
        do {
            try managedContext.save()
            //5
            places.append(result)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}
