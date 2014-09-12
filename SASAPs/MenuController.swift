//
//  MenuController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/21/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

class MenuController : UITableViewController, UITableViewDelegate, UITableViewDataSource{
    
    var expandedIndexPath: NSIndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tableCell: UITableViewCell = UITableViewCell(frame: CGRectMake(0, 0, 100, 70))
        return tableCell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(self.expandedIndexPath != nil){
            if(indexPath.compare(self.expandedIndexPath!) == NSComparisonResult.OrderedSame){
                return 100
            }
        }
        return 54
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.beginUpdates()
        if(indexPath.compare(self.expandedIndexPath!) == NSComparisonResult.OrderedSame){
            self.expandedIndexPath = nil
        }else{
            self.expandedIndexPath = indexPath
        }
        tableView.endUpdates()
    }
    
    
    
}