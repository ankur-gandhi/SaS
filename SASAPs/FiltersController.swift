//
//  FiltersController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/29/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

var result: FilterResult?
var filtersLkp = UtilityController.GetFiltersDictionary()
var appliedFilters = OrderedDictionary<String,[Filter]>()
var previousSearchFilters = AppliedFilter()
var api: APIController = APIController()
var viewFirstTimeLoaded : Bool = true
var selectedFilterCategory = ""

class FiltersController : UIViewController,UITableViewDataSource, UITableViewDelegate, JJTabBarControllerDelegate, APIControllerProtocol{
    @IBOutlet weak var filtersTableView: UITableView!
    @IBOutlet weak var verticalTabBar: JJTabBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
        
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        //self.navigationController.navigationBar.barTintColor = UIColor.blackColor()
        var tabViewsArray: Array = []
        var keyCount: Int = 0
        var firstBtn : UIButton = UIButton()
        for key in filtersLkp!.keys{
            var btn = UIButton(frame: CGRectMake(0, 0, 100, 50))
            btn.setTitle(key, forState: UIControlState.Normal)
            btn.addTarget(self, action: Selector("filterCategoryClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
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
        filterCategoryClicked(firstBtn)
    }
    
    func filterCategoryClicked(sender: UIButton){
        var keyCount: Int = 0
        for key in filtersLkp!.keys{
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
        applyClicked(sender)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("filterCell") as? UITableViewCell
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "filterCell")
        }
        
        Cell.prepareFilterCell(cell!, selectedFilterCategory: selectedFilterCategory, indexPath: indexPath, filters: filtersLkp!, appliedFilters: appliedFilters, tar: self)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(filtersLkp? != nil && filtersLkp![selectedFilterCategory] != nil){
            return filtersLkp![selectedFilterCategory]!.count
        }
        return 0
    }
    
    func filterClicked(recognizer: UITapGestureRecognizer){
        var nonSelectedImage : UIImage = UIImage(named: "uncheck")
        var selectedImage : UIImage = UIImage(named: "check")
        var hitPoint: CGPoint = recognizer.view!.convertPoint(CGPointZero, toView: filtersTableView)
        var tapIndexPath: NSIndexPath? = filtersTableView.indexPathForRowAtPoint(hitPoint)
        if(tapIndexPath != nil){
            if let cellToUpdate = filtersTableView.cellForRowAtIndexPath(tapIndexPath!){
                var imgView: UIImageView = cellToUpdate.viewWithTag(2) as UIImageView
                if(imgView.image == nonSelectedImage){
                    imgView.image = selectedImage
                }else{
                    imgView.image = nonSelectedImage
                }
            }
            addClickedFilterToAppliedFilters(tapIndexPath!)
        }
    }
    
    func addClickedFilterToAppliedFilters(indexPath: NSIndexPath){
        
        //appliedFilters is the dictionary of SelectedCategory (key)  and (Filters) values array.
        
        var selectedFilter : Filter? = nil
        if var values = filtersLkp![selectedFilterCategory]{
            selectedFilter = values[indexPath.row]
        }

        if(contains(appliedFilters.keys, selectedFilterCategory)){
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
    }
    
    @IBAction func applyClicked(sender: AnyObject) {
        var searchFilters = AppliedFilter()
        var contactValues : String = ""
        
        for key in appliedFilters.keys{
            contactValues = ""
            var values = appliedFilters[key]
            
            for val in values!{
                contactValues += val.value + ","
            }
            
            if(contactValues.hasSuffix(",")){
                contactValues = contactValues.substringToIndex(contactValues.endIndex.predecessor())
            }
            
            switch key {
            case "Gender":
                searchFilters.Gender = contactValues
            case "Age":
                searchFilters.AgeOfAP = contactValues
            default:
                searchFilters.Gender = ""
                searchFilters.AgeOfAP = ""
            }
        }
        
        if(!(previousSearchFilters == searchFilters) || viewFirstTimeLoaded){
            UtilityController.LoadingFunctions(self.navigationController!.view, show: true)
            viewFirstTimeLoaded = false
            previousSearchFilters = searchFilters
            api.post(UtilityController.APIURL + "/api/IOSApi/GetAupairsCount", params: searchFilters)
        }
        else{
            self.filtersTableView.reloadData()
        }
    }
    
    func didReceiveAPIResults(results: AnyObject) {
        var strData = NSString(data: results as NSData, encoding: NSUTF8StringEncoding)
        println(strData)

        result = FilterResult(string: strData as String, error: nil)
        dispatch_async(dispatch_get_main_queue(), {
            self.filtersTableView.reloadData()
            UtilityController.LoadingFunctions(nil, show: false)
        })
    }
    
    class var filterResult: FilterResult?{
        get{
            return result
        }
    }
    
    class var PreviousAppliedFilters: AppliedFilter{
        get{
            println(previousSearchFilters.AgeOfAP)
            return previousSearchFilters
        }
    }
}