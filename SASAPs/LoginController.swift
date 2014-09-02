//
//  LoginController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/22/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation
import UIKit

class LoginController:UIViewController, APIControllerProtocol{
    
    @IBAction func closeView(sender: UIBarButtonItem) {
        closeLoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func closeLoginView(){
        self.presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func buttonLoginClicked(sender: UIButton) {
        var api = APIController()
        api.delegate = self
        var params = ["passwd" : "Abbate7503", "email" : "catherineabbate@aol.com"] as NSDictionary
        api.post(UtilityController.APIURL + "/api/IOSApi/Login", params: params)
    }
    
    func didReceiveAPIResults(results: AnyObject) {
        var result = (results as? String)
        println(result)
        if(result != nil && result! == "true"){
            UserDefaults.saveUserDefaults("LoginInfo", key: "username", value: "ga.gandhi@gmail.com")
            closeLoginView()
        }else{
//            var alert = UIAlertController(title: "Login failed", message: "Login Failed", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
