//
//  MapViewController.swift
//  411AFRIQUE
//
//  Created by Azuka Omesiete on 11/21/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
   
    var session: URLSession!
    var applicationDelegate: AppDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let locationManager = CLLocationManager()
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "411 Afrique"
        mapView.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        activityIndicator.isHidden = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            //   locationManager.requestLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    //    self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  self.unsubscribeFromKeyboardNotification()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if locations.first != nil {
            
            let userLoction: CLLocation = locations[0]
            let latitude = userLoction.coordinate.latitude
            print(latitude)
            appDelegate.latitude = latitude
            let longitude = userLoction.coordinate.longitude
            print(longitude)
            appDelegate.longitude = longitude
            if appDelegate.longitude != nil {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            }
            let latDelta: CLLocationDegrees = 0.05
            let lonDelta: CLLocationDegrees = 0.05
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
        }
    }
    
       @IBAction func textFieldReturn(_ sender: AnyObject) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        performSearch()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
 
        func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
            let alert = UIAlertController(title: "Alert", message: "Error Finding Location", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("error:: (error)")
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    
    func zoomIn(_ longitude: CLLocationDegrees, latitude: CLLocationDegrees) {
        let span = MKCoordinateSpanMake(0.075, 0.075)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    func performSearch() {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText.text
        request.region = mapView.region
        activityIndicator.startAnimating()
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("There was an error searching for: \(request.naturalLanguageQuery) error: \(error)")
                let alert = UIAlertController(title: "Alert", message: "Error Finding Location", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                self.location = item.placemark.location
                annotation.title = item.name
                self.mapView.addAnnotation(annotation)
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
               self.appDelegate.latitude = (self.location?.coordinate.latitude)!
               self.appDelegate.longitude = (self.location?.coordinate.longitude)!
               self.zoomIn(self.appDelegate.longitude, latitude: self.appDelegate.latitude)
        }
    }
        
        @IBAction func findMe(sender: AnyObject) {
            print("location")
            activityIndicator.isHidden = false
            
            activityIndicator.startAnimating()
            let annotation = MKPointAnnotation()
            locationManager.requestLocation()
                
     
            
            appDelegate.latitude = annotation.coordinate.latitude
            appDelegate.longitude = annotation.coordinate.longitude
       
        }
        
        func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.pinColor = .red
                pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else {
                pinView!.annotation = annotation
            }
            
            return pinView
        }
        
        class func sharedInstance() -> MapViewController {
            struct Singleton {
                static var sharedInstance = MapViewController()
            }
            return Singleton.sharedInstance
        }
    
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true;
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if searchText.isFirstResponder {
            self.view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    // writing the method to hide keyboard
    func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    //  set method to subscribe keyboard
    func subscribeToKeyboardNotifications()  {
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //set unsubscribe method for keyboard
    func unsubscribeFromKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchText.resignFirstResponder()

    }

    
    
        
}
