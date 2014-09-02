//
//  NavigationController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/20/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation
import UIKit

class NavigationController : UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var panGesture = UIPanGestureRecognizer(target: self, action: "panGestureRecognized:")
        self.view.addGestureRecognizer(panGesture)
    }
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer!) {
        self.view.endEditing(true)
        println(self.frostedViewController)
        self.frostedViewController.view.endEditing(true)
        self.frostedViewController.panGestureRecognized(recognizer)
    }
}