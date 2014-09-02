//
//  AppDelegate.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/18/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        var sb: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
//        var rootViewController: UIViewController = sb.instantiateViewControllerWithIdentifier("mainNavigantion") as UIViewController
//        var s : SlideNavigationController = SlideNavigationController(rootViewController:rootViewController)
//        s.navigationBarHidden = true
//        s.navigationBar.translucent = false
        
        
        
//        var tabBar : UITabBar = rootViewController.tabBar
//        var tabBarItem1: UITabBarItem = tabBar.items[0] as UITabBarItem
//        var tabBarItem2: UITabBarItem = tabBar.items[1] as UITabBarItem
//        var tabBarItem3: UITabBarItem = tabBar.items[2] as UITabBarItem
        
//        tabBar.layer.borderColor = UIColor.redColor().CGColor
//        tabBar.layer.borderWidth = 1
        
//        self.window?.rootViewController = s
//        self.window?.makeKeyAndVisible()
        
        // Creating a custom bar button for right menu
//        UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//        [button setImage:[UIImage imageNamed:@"gear"] forState:UIControlStateNormal];
//        [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//        [SlideNavigationController sharedInstance].rightBarButtonItem = rightBarButtonItem;
        
        

        return true
    }

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

