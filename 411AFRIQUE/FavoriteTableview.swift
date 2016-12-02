//
//  FavoriteTableview.swift
//  411AFRIQUE
//
//  Created by iOS3 on 01/12/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import UIKit

class FavoriteTableview: NSObject, UITableViewDataSource, UITableViewDelegate {
    var arrTableData = NSArray()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //    Place.placeArray = arrTableData as! [Place]
        //    return Place.placeArray.count
        return arrTableData.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath)
        
        let tempArray = arrTableData[indexPath.row]//Place.placeArray[indexPath.row]//arrTableData[indexPath.row]
      //  let isFav = (tempArray as AnyObject).value(forKey: "isFavorite") as? Bool
        cell.textLabel?.text = (tempArray as AnyObject).value(forKey: "name") as? String//Place.placeArray[indexPath.row].name
        cell.detailTextLabel?.text = (tempArray as AnyObject).value(forKey: "address") as? String//Place.placeArray[indexPath.row].address
        
        return cell
        
    }
    
}
