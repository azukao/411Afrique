//
//  ViewController.swift
//  411AFRIQUE
//
//  Created by Azuka Omesiete on 11/8/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import UIKit
import GooglePlaces

class PickerViewController: UIViewController {
    
    var placesClient: GMSPlacesClient?
    var type = String()
    @IBOutlet weak var restaurant: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Select a Business"
        // Do any additional setup after loading the view, typically from a nib.
     print(appDelegate.latitude)
        print(appDelegate.longitude)
    }
   
    
    
    @IBAction func currentLocation(sender: AnyObject) {
      MapViewController.sharedInstance().locationManager.requestLocation()
    }
    @IBAction func btnRestaurantTapped(_ sender: Any) {
        type = "restaurant"
        GoogleClient.sharedInstance().findBusiness(type: "restaurant") {
            
            (success, erorMessage) in
            DispatchQueue.main.async {
                if success {

                    let ResultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    ResultVC.placeType = self.type
                    self.navigationController?.pushViewController(ResultVC, animated: true)
                    print(success)
                }
            }
            
        }

    }    
    @IBAction func btnShopTapped(_ sender: Any) {
        type = "store"
        GoogleClient.sharedInstance().findBusiness(type: "store") {
            (success, erorMessage) in
            DispatchQueue.main.async {
                if success {
                    //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //                    let navController = UINavigationController()
                    let ResultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    ResultVC.placeType = self.type
                    self.navigationController?.pushViewController(ResultVC, animated: true)
                    print(success)
                }
            }
            
        }
    }
    @IBAction func btnTailorTapped(_ sender: Any) {
        type = "clothing_store"
        GoogleClient.sharedInstance().findBusiness(type: "clothing_store") {
            (success, erorMessage) in
            DispatchQueue.main.async {
                if success {
                    //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //                    let navController = UINavigationController()
                    let ResultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    ResultVC.placeType = self.type
                    self.navigationController?.pushViewController(ResultVC, animated: true)
                    print(success)
                }
            }
            
        }
    }
    
    @IBAction func btnSalonTapped(_ sender: Any) {
        type = "salon"
        
        GoogleClient.sharedInstance().findBusiness(type: "salon") {
            (success, erorMessage) in
            DispatchQueue.main.async {
                if success {
                    //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //                    let navController = UINavigationController()
                    let ResultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    ResultVC.placeType = self.type
                    self.navigationController?.pushViewController(ResultVC, animated: true)
                    print(success)
                }
            }
            
        }
    }
    @IBAction func btnNightClubTapped(_ sender: Any) {
        type = "night_club"
        GoogleClient.sharedInstance().findBusiness(type: "night_club") {
            (success, erorMessage) in
            DispatchQueue.main.async {
                if success {
                    //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //                    let navController = UINavigationController()
                    let ResultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    ResultVC.placeType = self.type
                    self.navigationController?.pushViewController(ResultVC, animated: true)
                    print(success)
                }
            }
            
        }
    }
    @IBAction func btnEventTapped(_ sender: Any) {
        type = "event"
        GoogleClient.sharedInstance().findBusiness(type: "event") {
            (success, erorMessage) in
            DispatchQueue.main.async {
                if success {
                    //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //                    let navController = UINavigationController()
                    let ResultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    ResultVC.placeType = self.type
                    self.navigationController?.pushViewController(ResultVC, animated: true)
                    print(success)
                }
            }
            
        }
    }
    @IBAction func btnChurchTapped(_ sender: Any) {
        type = "church"
        GoogleClient.sharedInstance().findBusiness(type: "church") {
            (success, erorMessage) in
            DispatchQueue.main.async {
                if success {
                    //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //                    let navController = UINavigationController()
                    let ResultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    ResultVC.placeType = self.type
                    self.navigationController?.pushViewController(ResultVC, animated: true)
                    print(success)
                }
            }
            
        }
    }
    @IBAction func btnMosqueTapped(_ sender: Any) {
        type = "mosque"
        GoogleClient.sharedInstance().findBusiness(type: "mosque") {
            (success, erorMessage) in
            DispatchQueue.main.async {
                if success {
                    //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //                    let navController = UINavigationController()
                    let ResultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    ResultVC.placeType = self.type
                    self.navigationController?.pushViewController(ResultVC, animated: true)
                    print(success)
                }
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

