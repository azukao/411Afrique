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
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if locations.first != nil {
            
            let userLoction: CLLocation = locations[0]
            let latitude = userLoction.coordinate.latitude
            print(latitude)
            appDelegate.latitude = latitude
            let longitude = userLoction.coordinate.longitude
            print(longitude)
            appDelegate.longitude = longitude
            let latDelta: CLLocationDegrees = 0.05
            let lonDelta: CLLocationDegrees = 0.05
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
 
        func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
            print("error:: (error)")
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
        
}
