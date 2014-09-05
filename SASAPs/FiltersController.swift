//
//  FiltersController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/29/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

class FiltersController : UIViewController,UITableViewDataSource, UITableViewDelegate, JJTabBarControllerDelegate{
    
    
    var filtersLkp = UtilityController.GetFiltersDictionary()
    var selectedFilterCategory = ""
    var appliedFilters = OrderedDictionary<String,[Filter]>()
    
    @IBOutlet weak var filtersTableView: UITableView!
    @IBOutlet weak var verticalTabBar: JJTabBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController.navigationBar.tintColor = UIColor.whiteColor()
        //self.navigationController.navigationBar.barTintColor = UIColor.blackColor()
        
        var tabViewsArray: Array = []
        var keyCount: Int = 0
        var firstBtn : UIButton = UIButton()
        for key in filtersLkp.keys{
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
        for key in filtersLkp.keys{
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
        
        Cell.prepareFilterCell(cell, selectedFilterCategory: selectedFilterCategory, indexPath: indexPath, filters: filtersLkp, tar: self)
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if(filtersLkp != nil && filtersLkp[selectedFilterCategory] != nil){
            return filtersLkp[selectedFilterCategory]!.count
        }
        return 0
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
            }
            addToAppliedFilters(tapIndexPath!)
        }
    }
    
    func addToAppliedFilters(indexPath: NSIndexPath){
        
        var selectedFilter : Filter? = nil
        if var values = filtersLkp[selectedFilterCategory]{
            selectedFilter = values[indexPath.row]
        }

        if(contains(appliedFilters.keys, self.selectedFilterCategory)){
            //add or remove applied filter
            if selectedFilter != nil{
                if var appliedFiltersArray = appliedFilters[selectedFilterCategory] {
                    // remove it if it is already present.
                    // add if if it does not exist
                    if let index = find(appliedFiltersArray, selectedFilter!){
                        appliedFiltersArray.removeAtIndex(index)
                    }
                    else{
                        appliedFiltersArray.append(selectedFilter!)
                    }
                    appliedFilters[selectedFilterCategory] = appliedFiltersArray
                }
            }
        }
        else{
            
            //If selected category does not exists then add it with selected filter
            if(selectedFilter != nil){
                var appliedFiltersArray = [Filter]()
                appliedFiltersArray.append(selectedFilter!)
                appliedFilters[selectedFilterCategory] = appliedFiltersArray
            }
            
        }
        
        println(appliedFilters.keys)
    }
}