//
//  UtilityController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/22/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation
import UIKit

class UtilityController {
        
    class func getMenuItems(tar: ViewController) -> [KxMenuItem]{
        var menuItems : Array = []
        var menuItemSpaceString: String = "   "
        var loginString : String = menuItemSpaceString + "Login"
        var userName = UserDefaults.getUserDefaults("LoginInfo", key: "username") as? String
        if userName != nil{
            loginString = menuItemSpaceString + (userName!)
        }
        
        menuItems.append(KxMenuItem(loginString, image: UIImage(named: "lock16.png"), target: tar, action: Selector("openLoginView")))
        menuItems.append(KxMenuItem(menuItemSpaceString + "Watch List", image: UIImage(named: "heart16.png"), target: tar, action: Selector("openLoginView")))
        menuItems.append(KxMenuItem(menuItemSpaceString + "Recently Viewed", image: UIImage(named: "recentview.png"), target: tar, action: Selector("openLoginView")))
        
        if userName != nil{
             menuItems.append(KxMenuItem(menuItemSpaceString + "Logout", image: UIImage(named: "exit.png"), target: tar, action: Selector("logout")))
        }
        
        return menuItems as [KxMenuItem]
    }
    
    class func prepareAPThumbnailCell(cell: UITableViewCell, ap: AnyObject, tar: ViewController){
        var lblName: UITextView? = cell.viewWithTag(1) as? UITextView
        var countryLbl: UITextView? = cell.viewWithTag(4) as? UITextView
        var padLbl: UILabel? = cell.viewWithTag(6) as? UILabel

        var recognizer = UITapGestureRecognizer(target: tar, action:Selector("tapDetected:"))
        var favIconIV: UIImageView = cell.viewWithTag(7) as UIImageView
        favIconIV.image = UIImage(named: "Favorites24.png")
        favIconIV.userInteractionEnabled = true
        favIconIV.addGestureRecognizer(recognizer)

        
        var apName: String = ap["FirstName"] as String
        apName += ", "
        apName += String(ap["AgeOnArrival"] as Int)
        lblName?.text =  apName
        lblName?.setNeedsDisplay()
        countryLbl?.text = ap["CountryName"] as? String
        countryLbl?.setNeedsDisplay()
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        var arrivalDate:String = ap["AupairArrivalDate"] as String
        if let end = find(arrivalDate,"."){
            arrivalDate = arrivalDate[arrivalDate.startIndex..<end]
        }
        
        var d: NSDate = dateStringFormatter.dateFromString(arrivalDate)
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        padLbl?.text = dateStringFormatter.stringFromDate(d)
        padLbl?.setNeedsDisplay()
        
        cell.clipsToBounds = true
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        //return cell
    }
    
    class var APIURL: String{
        get{
            return "http://10.39.42.51"
            //return "http://10.0.0.8"
        }
    }
}