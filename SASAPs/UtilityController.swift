//
//  UtilityController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/22/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation
import UIKit

var hud: MBProgressHUD? = nil

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
    
    class var APIURL: String{
        get{
            //return "http://10.39.42.51"
            return "http://10.0.0.8"
        }
    }
    
    class func removeSubViews(cell: UITableViewCell, tagsToRemove: [Int]){
        for sv: AnyObject in cell.subviews{
            if (contains(tagsToRemove, sv.tag)){
                sv.removeFromSuperview()
            }
        }
    }
    
    class func GetFiltersDictionary() -> OrderedDictionary<String, [Filter]>{
        
        var filterDict : OrderedDictionary<String, [Filter]> = OrderedDictionary<String, [Filter]>()
                
        //var filterDict = Dictionary<String, [Filter]>()
        filterDict["Gender"] = GetGenderFilters()
        filterDict["Age"] = GetAgeFilters()
        return filterDict
    }
    
    class func GetGenderFilters() -> [Filter]{
        var filters = [Filter]()
        filters.append(Filter(name: "Female", value: "F"))
        filters.append(Filter(name: "Male", value: "M"))
        return filters
    }
    
    class func GetAgeFilters() -> [Filter]{
        var filters = [Filter]()
        filters.append(Filter(name: "18", value: "18"))
        filters.append(Filter(name: "19", value: "19"))
        filters.append(Filter(name: "20", value: "20"))
        filters.append(Filter(name: "21", value: "21"))
        filters.append(Filter(name: "22", value: "22"))
        filters.append(Filter(name: "23", value: "23"))
        filters.append(Filter(name: "24", value: "24"))
        filters.append(Filter(name: "25", value: "25"))
        filters.append(Filter(name: "26", value: "26"))
        return filters
    }
    
    class func LoadingFunctions(view: UIView?, show: Bool){
        if(show){
            hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
            hud?.labelText = "Loading"
        }else{
            hud?.hide(true)
        }
    }
    
    class var ProgressBar: MBProgressHUD?{
        get{
            return hud
        }
    }
}