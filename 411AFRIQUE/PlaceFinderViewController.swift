//
//  PlaceFinderViewController.swift
//  411AFRIQUE
//
//  Created by Azuka Omesiete on 11/18/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class PlaceFinderViewController: UIViewController {
    
    var placesClient: GMSPlacesClient?
    
    // Add a pair of UILabels in Interface Builder, and connect the outlets to these variables.
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
    }
    
    // Add a UIButton in Interface Builder, and connect the action to this function.
    @IBAction func getCurrentPlace(sender: AnyObject) {
        
        placesClient?.currentPlace(callback: {
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            self.nameLabel.text = "No current place"
            self.addressLabel.text = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    self.nameLabel.text = place.name
                    self.addressLabel.text = place.formattedAddress!
                }
            }
        } as! GMSPlaceLikelihoodListCallback)
    }
    

}

