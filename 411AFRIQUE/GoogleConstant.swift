//
//  googleConstants.swift
//  411AFRIQUE
//
//  Created by Azuka Omesiete on 11/19/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import Foundation

class GoogleConstant: NSObject {
    
    struct urlLink {
        
    }
    
    struct Keys {
        static let API_KEY = "AIzaSyBxqjKfHgRpBTLWur51uKgwd9_e0Wa2NHc"
        static let location = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    }
    
    struct Parameters {
        static let LAT = "lat"
        static let LON = "lon"
        static let API = "&key="
        static let LOC = "&location="
        static let RADIUS = "&radius="
        static let TYPE = "&type="
        static let KEYWORD = "&keyword="
    }
    
    
    struct JSONResponseKeys {
        static let result = "results"
        static let Name = "name"
        static let Address = "vicinity"
        static let id = "id"
      
    }
}
