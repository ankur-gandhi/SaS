//
//  FavoritesViewController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/21/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation
import Foundation

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating a custom bar button for right menu
        menuButton.addTarget(SlideNavigationController.sharedInstance(), action: Selector("toggleLeftMenu"), forControlEvents: UIControlEvents.TouchUpInside)
    }
}