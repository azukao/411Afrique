//
//  Place.swift
//  411AFRIQUE
//
//  Created by Azuka Omesiete on 11/23/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import Foundation
import MapKit


struct Place {
    
    var name:String?
    var address: String?
    var id: String?

    
    
    
    static var placeArray = [Place]()
    
    init(dictionary: [String: AnyObject]){
        if dictionary["name"] != nil {
            name = dictionary["name"] as? String
        }
        if dictionary["vicinity"] != nil {
            address = dictionary["vicinity"] as? String
        }
        if dictionary["id"] != nil {
            id = dictionary["id"] as? String
        }
    }
    

    static func placesFromArray(placeData: NSArray) -> [Place] {
        var place = [Place]()
        for placeInfo in placeData {
            let Places = Place(dictionary: placeInfo as! [String : AnyObject])
            place.append(Places)
        }
        return place
    }
    
    static func convertFromDictionaries(_ array: [[String: AnyObject]]) -> [Place] {
        var resultArray = [Place]()
        
        for dictionary in array {
            resultArray.append(Place(dictionary: dictionary))
        }
        
        return resultArray
}
}
