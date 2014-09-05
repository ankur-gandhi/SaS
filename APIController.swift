//
//  APIController.swift
//  JsonParse
//
//  Created by Ankur Gandhi on 8/13/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

class APIController{
    
    var delegate: APIControllerProtocol?
    
    init(){
        
    }
    
    func post(path: String, params: NSDictionary){
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        var err: NSError?
        var request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var handler : (NSData!, NSURLResponse!, NSError!) -> () = {
            data, response, error -> Void in
            println("Response: \(response)")
            if(error) {
                println(error.localizedDescription)
            }
            var err: NSError?
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            if(err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            self.delegate?.didReceiveAPIResults(strData)
        }
        
        let task = session.dataTaskWithRequest(request, handler)
        task.resume()
    }
    
    func get(path: String){
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        
        var handler : (NSData!, NSURLResponse!, NSError!) -> () = {
            data, response, error -> Void in
            println("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            self.delegate?.didReceiveAPIResults(jsonResult)
        }
        
        let task = session.dataTaskWithURL(url, handler)
        task.resume()
    }
}


protocol APIControllerProtocol{
    func didReceiveAPIResults(results: AnyObject)
}