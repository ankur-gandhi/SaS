//
//  FiltersController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/29/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

class FiltersController : UIViewController,UITableViewDataSource, UITableViewDelegate, JJTabBarControllerDelegate{
    
    
    var filters : Dictionary<String,[Filter]> = UtilityController.GetFiltersDictionary()
    var selectedFilterCategory = ""
    
    @IBOutlet weak var filtersTableView: UITableView!
    @IBOutlet weak var verticalTabBar: JJTabBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController.navigationBar.tintColor = UIColor.whiteColor()
        //self.navigationController.navigationBar.barTintColor = UIColor.blackColor()
        
        var tabViewsArray: Array = []
        var keyCount: Int = 0
        var firstBtn : UIButton = UIButton()
        for key in filters.keys{
            var btn = UIButton(frame: CGRectMake(0, 0, 100, 50))
            btn.setTitle(key, forState: UIControlState.Normal)
            btn.addTarget(self, action: Selector("btnClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
            btn.tag = keyCount + 100
            tabViewsArray.append(btn)
            if(keyCount == 0){
                firstBtn = btn
            }
            keyCount++
        }

        
        self.verticalTabBar.backgroundImage = UIImage(named: "blackHorizontalBar")
        self.verticalTabBar.scrollEnabled = false
        self.verticalTabBar.autoResizeChilds = false
        self.verticalTabBar.centerTabBarOnSelect = false
        self.verticalTabBar.alwaysCenterTabBarOnSelect = false
        self.verticalTabBar.alignment = JJBarViewAlignment.Vertical
        self.verticalTabBar.sizeToFit()
        self.verticalTabBar.imageSeparator = UIImage(named: "line2")
        self.verticalTabBar.childViews = tabViewsArray
        btnClicked(firstBtn)
    }
    
    func btnClicked(sender: UIButton){
        var keyCount: Int = 0
        for key in filters.keys{
            if(sender.tag == (keyCount + 100)){
                sender.backgroundColor = self.filtersTableView.backgroundColor
                sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                selectedFilterCategory = key
            }
            else{
                var btn = self.view.viewWithTag(keyCount + 100) as? UIButton
                btn?.backgroundColor = UIColor.clearColor()
                btn?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            }
            keyCount++
        }
        filtersTableView.reloadData()
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("filterCell") as UITableViewCell
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "filterCell")
        }
        
        removeSubViews(cell)
        var lbl = UILabel(frame: CGRectMake(10, 10, 100, 50))
        var filterVal : [Filter] = filters[selectedFilterCategory]! as [Filter]
        lbl.text = filterVal[indexPath.row].name
        lbl.sizeToFit()
        lbl.setNeedsDisplay()
        lbl.tag = 1
        cell.addSubview(lbl)
        
        var uncheckImg = UIImage(named: "uncheck")
        var recognizer = UITapGestureRecognizer(target: self, action:Selector("tapDetected:"))
        var imgView = UIImageView(image: uncheckImg)
        imgView.frame.origin = CGPoint(x: UIScreen.mainScreen().bounds.size.width - 150, y: 8)
        imgView.userInteractionEnabled = true
        imgView.addGestureRecognizer(recognizer)
        imgView.tag = 2
        cell.addSubview(imgView)
        
        return cell
    }
    
    func tapDetected(recognizer: UITapGestureRecognizer){
        var nonSelectedImage : UIImage = UIImage(named: "uncheck")
        var selectedImage : UIImage = UIImage(named: "check")
        var hitPoint: CGPoint = recognizer.view.convertPoint(CGPointZero, toView: filtersTableView)
        var tapIndexPath: NSIndexPath? = filtersTableView.indexPathForRowAtPoint(hitPoint)
        if(tapIndexPath != nil){
            if let cellToUpdate = filtersTableView.cellForRowAtIndexPath(tapIndexPath){
                var imgView: UIImageView = cellToUpdate.viewWithTag(2) as UIImageView
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
    
    func removeSubViews(cell: UITableViewCell){
        for sv: AnyObject in cell.subviews{
            if ((sv is UILabel) || (sv is UIImageView)){
                sv.removeFromSuperview()
            }
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if(filters != nil && filters[selectedFilterCategory] != nil){
            return filters[selectedFilterCategory]!.count
        }
        return 0
    }
}