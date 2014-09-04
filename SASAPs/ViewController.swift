//
//  ViewController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/18/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
    
    @IBOutlet weak var tbView: UITableView!
    
    var api = APIController()
    var apList = NSArray()
    var imageCache : Dictionary<String, UIImage> = Dictionary<String,UIImage>()
    
    
    func openLoginView() {
        var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var loginController = storyboard.instantiateViewControllerWithIdentifier("loginStoryBoard") as UIViewController
        self.presentViewController(loginController, animated: true, completion: nil)
    }
    
    func logout(){
        UserDefaults.removeUserDefaults("LoginInfo", key: "username")
        var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var loginController = storyboard.instantiateViewControllerWithIdentifier("loginStoryBoard") as UIViewController
        self.view.setNeedsDisplay()
    }
    
    @IBAction func openMenu(sender: UIButton) {
        KxMenu.showMenuInView(self.parentViewController.view, fromRect: sender.frame, menuItems: UtilityController.getMenuItems(self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        api.delegate = self
        api.get(UtilityController.APIURL + "/api/IOSApi/GetAupairs")
        
        var leftMenu : MenuController = MenuController()
        var navController = SlideNavigationController.sharedInstance()
        navController.leftMenu = leftMenu
        navController.enableSwipeGesture = true
        navController.panGestureSideOffset = 50
        navController.portraitSlideOffset = 100

        var button: UIButton = UIButton(frame: CGRectMake(0, 0, 30, 30))
        button.setImage(UIImage(named: "vertical.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("openMenu:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        var leftButton: UIButton = UIButton(frame: CGRectMake(0, 0, 30, 30))
        leftButton.setImage(UIImage(named: "1408585283_menu-alt.png"), forState: UIControlState.Normal)
        leftButton.addTarget(navController, action: Selector("toggleLeftMenu"), forControlEvents: UIControlEvents.TouchUpInside)

        
        var rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: button)
        rightBarButtonItem.imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        SlideNavigationController.sharedInstance().rightBarButtonItem = rightBarButtonItem
        
        var leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        SlideNavigationController.sharedInstance().leftBarButtonItem = leftBarButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slideNavigationControllerShouldDisplayLeftMenu()-> Bool{
        return true
    }
    
    func slideNavigationControllerShouldDisplayRightMenu()-> Bool{
        return true
    }

    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("APThumbNailCell") as UITableViewCell
        let ap: AnyObject = self.apList[indexPath.row]
        
        var urlString = ap["PhotoUrl"] as String
        urlString = UtilityController.APIURL + "/GetImage.ashx?w=100&h=120&p=" + urlString
        var image = self.imageCache[urlString]
        
        if(image == nil){
            var imgUrl: NSURL = NSURL(string: urlString)
            let request : NSURLRequest = NSURLRequest(URL: imgUrl)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
                (response: NSURLResponse!, data: NSData!, error:NSError!) -> Void in
                if error == nil {
                    image = UIImage(data: data)
                    self.imageCache[urlString] = image
                    if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath){
                        var imgView: UIImageView = cellToUpdate.viewWithTag(2) as UIImageView
                        imgView.layer.cornerRadius = 3.0;
                        imgView.layer.borderColor = UIColor.grayColor().CGColor
                        imgView.layer.borderWidth = 2.0
                        imgView.contentMode = UIViewContentMode.ScaleAspectFit
                        imgView.image = image
                    }
                }else{
                    println("Error : \(error.localizedDescription)")
                }
            })
        }else{
            
            dispatch_async(dispatch_get_main_queue(), {
                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath){
                    var imgView: UIImageView = cellToUpdate.viewWithTag(2) as UIImageView
                    imgView.contentMode = UIViewContentMode.ScaleAspectFit
                    imgView.image = image
                }
            })
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            UtilityController.prepareAPThumbnailCell(cell, ap: ap, tar: self)
        })
        
        return cell

    }
    
    func tapDetected(recognizer: UITapGestureRecognizer){
        
        var nonSelectedImage : UIImage = UIImage(named: "Favorites24.png")
        var selectedImage : UIImage = UIImage(named: "Favorites24Red.png")
        
        if(tbView != nil){
            //var tbView : UITableView = tblView!
            var hitPoint: CGPoint = recognizer.view.convertPoint(CGPointZero, toView: tbView)
            var tapIndexPath: NSIndexPath? = tbView.indexPathForRowAtPoint(hitPoint)
            if(tapIndexPath != nil){
                if let cellToUpdate = tbView.cellForRowAtIndexPath(tapIndexPath){
                    var imgView: UIImageView = cellToUpdate.viewWithTag(7) as UIImageView
                    if(imgView.image == nonSelectedImage){
                        imgView.image = selectedImage
                    }else{
                        imgView.image = nonSelectedImage
                    }
                }else{
                    println("cell not found")
                }
            }
        }
    }
    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!) {
        cell.contentView.backgroundColor = UIColor.clearColor()
        var roundedView : UIView = UIView(frame: CGRectMake(5 , 5, cell.contentView.bounds.width-10, 110))
        roundedView.backgroundColor = UIColor.whiteColor()
        roundedView.layer.masksToBounds = true
        roundedView.layer.cornerRadius = 3.0
        cell.contentView.addSubview(roundedView)
        cell.contentView.sendSubviewToBack(roundedView)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return apList.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue != nil && segue.identifier != nil && segue.identifier == "apDetailViewSegue"{
            var destVC = segue.destinationViewController as APDetailViewController
            destVC.selectedAupairId = apList[self.tbView.indexPathForSelectedRow().row]["AupairKey"] as String
        }
    }
    
    func didReceiveAPIResults(results: AnyObject) {
        apList = results as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.tbView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
}


