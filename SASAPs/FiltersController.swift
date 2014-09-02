//
//  FiltersController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/29/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

class FiltersController : UIViewController{
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func changeTVContent(sender: AnyObject) {
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.whiteColor().CGColor
        var btn : UIButton = sender as UIButton
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.layer.backgroundColor = UIColor.whiteColor().CGColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}