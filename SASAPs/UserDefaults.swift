//
//  UserDefaults.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/27/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

class UserDefaults{
    
    class func saveUserDefaults(suitname: String, key: String, value: String){
        var defaults: NSUserDefaults = NSUserDefaults(suiteName: suitname)
        defaults.setValue(value, forKey: key)
    }
    
    class func getUserDefaults(suitname: String, key: String) -> AnyObject?{
        var defaults: NSUserDefaults = NSUserDefaults(suiteName: suitname)
        return defaults.valueForKey(key)
    }
    
    class func removeUserDefaults(suitname: String, key: String){
        var defaults: NSUserDefaults = NSUserDefaults(suiteName: suitname)
        defaults.removeObjectForKey(key)
    }

}
