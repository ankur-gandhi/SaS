//
//  CellController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 9/4/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

class Cell{
    class func prepareAPThumbnailCell(cell: UITableViewCell, ap: AnyObject, tar: UIViewController){
        
        var recognizer = UITapGestureRecognizer(target: tar, action:Selector("tapDetected:"))
        var favIconIV: UIImageView = cell.viewWithTag(7) as UIImageView
        favIconIV.image = UIImage(named: "Favorites24.png")
        favIconIV.userInteractionEnabled = true
        favIconIV.addGestureRecognizer(recognizer)
        
        var apName: String = ap["FirstName"] as String
        apName += ", "
        apName += String(ap["AgeOnArrival"] as Int)
        
        UtilityController.removeSubViews(cell, tagsToRemove: [100,101,102])
        
        cell.clipsToBounds = true
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        var lblName: UILabel = UILabel(frame: CGRectMake(105, 15, 200, 100))
        lblName.text =  apName
        lblName = GetCustomizedLabel(lblName)
        lblName.tag = 100
        cell.contentView.addSubview(lblName)
        
        var countryLbl: UILabel = UILabel(frame: CGRectMake(200, 55,  100, 50))
        countryLbl.text = ap["CountryName"] as? String
        countryLbl = GetCustomizedLabel(countryLbl)
        countryLbl.tag = 101
        cell.contentView.addSubview(countryLbl)
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        var arrivalDate:String = ap["AupairArrivalDate"] as String
        if let end = find(arrivalDate,"."){
            arrivalDate = arrivalDate[arrivalDate.startIndex..<end]
        }
        
        var d: NSDate? = dateStringFormatter.dateFromString(arrivalDate)
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        
        var padLbl: UILabel = UILabel(frame: CGRectMake(200, 75, 100, 50))
        padLbl.text = dateStringFormatter.stringFromDate(d!)
        padLbl = GetCustomizedLabel(padLbl)
        padLbl.tag = 102
        cell.contentView.addSubview(padLbl)
    }
    
    class func prepareFilterCell(cell: UITableViewCell, selectedFilterCategory: String,
        indexPath: NSIndexPath, filters: OrderedDictionary<String,[Filter]>,
        appliedFilters: OrderedDictionary<String,[Filter]>, tar: UIViewController){
            
        UtilityController.removeSubViews(cell, tagsToRemove: [1,2])
        var lbl = UILabel(frame: CGRectMake(20, 10, 100, 50))
        var filterVal : [Filter] = filters[selectedFilterCategory]! as [Filter]
        var filter: Filter = filterVal[indexPath.row]
        lbl.text = filter.name + GetCounts(selectedFilterCategory, value: filter.value)
        lbl.sizeToFit()
        lbl.setNeedsDisplay()
        lbl.tag = 1
        cell.contentView.addSubview(lbl)
        
        var uncheckImg = UIImage(named: "uncheck")
        var recognizer = UITapGestureRecognizer(target: tar, action:Selector("filterClicked:"))
            
        if(filterExistsInAppliedFiltersDict(filter, appliedFilters: appliedFilters, selectedFilterCategory: selectedFilterCategory)){
            uncheckImg = UIImage(named: "check")
        }
        var imgView = UIImageView(image: uncheckImg)
        imgView.frame.origin = CGPoint(x: UIScreen.mainScreen().bounds.size.width - 150, y: 8)
        imgView.userInteractionEnabled = true
        imgView.addGestureRecognizer(recognizer)
        imgView.tag = 2
        cell.contentView.addSubview(imgView)
    }
    
    class func filterExistsInAppliedFiltersDict(filter: Filter,
        appliedFilters: OrderedDictionary<String,[Filter]>, selectedFilterCategory: String) -> Bool{
     
            if var filterVal = appliedFilters[selectedFilterCategory] as [Filter]?{
                if let index = find(filterVal, filter){
                    return true
                }
            }
            return false
    }
    
    class func GetCounts(selectedFilterCategory : String, value: String) -> String{
        var count : Int = 0
        var valueArray: NSArray? = nil
        switch selectedFilterCategory{
            case "Gender":
                valueArray = FiltersController.filterResult?.isFemale
                count = GetCountFromArray(valueArray?, value: value)
            case "Age":
                valueArray = FiltersController.filterResult?.ageOnArrival
                count = GetCountFromArray(valueArray?, value: value)
            default: count =  0
        }
        
        if(count > 0){
            return " (" + String(count) + ")"
        }
        
        return ""
    }
    
    class func GetCountFromArray(valueArray : NSArray?, value: String) -> Int{
        var count : Int = 0
        if(valueArray != nil){
            for obj :AnyObject in valueArray!{
                var filter = FilterResultModel(obj: obj)
                if(filter.Id == value){
                    count = filter.Count
                    break
                }
            }
        }
        
        return count
    }
    
    class func GetCustomizedLabel(lbl: UILabel)-> UILabel{
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFontOfSize(12.0)
        lbl.sizeToFit()
        lbl.setNeedsDisplay()
        return lbl
    }
}