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
        
        var lblName: UILabel = UILabel(frame: CGRectMake(105, 15, 200, 100))
        lblName.text =  apName
        lblName = GetCustomizedLabel(lblName)
        lblName.tag = 100
        cell.addSubview(lblName)
        
        var countryLbl: UILabel = UILabel(frame: CGRectMake(200, 55,  100, 50))
        countryLbl.text = ap["CountryName"] as String
        countryLbl = GetCustomizedLabel(countryLbl)
        countryLbl.tag = 101
        cell.addSubview(countryLbl)
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        var arrivalDate:String = ap["AupairArrivalDate"] as String
        if let end = find(arrivalDate,"."){
            arrivalDate = arrivalDate[arrivalDate.startIndex..<end]
        }
        
        var d: NSDate = dateStringFormatter.dateFromString(arrivalDate)
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        
        var padLbl: UILabel = UILabel(frame: CGRectMake(200, 75, 100, 50))
        padLbl.text = dateStringFormatter.stringFromDate(d)
        padLbl = GetCustomizedLabel(padLbl)
        padLbl.tag = 102
        cell.addSubview(padLbl)
        
        cell.clipsToBounds = true
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
    
    class func prepareFilterCell(cell: UITableViewCell, selectedFilterCategory: String, indexPath: NSIndexPath, filters: OrderedDictionary<String,[Filter]>, tar: UIViewController){
        UtilityController.removeSubViews(cell, tagsToRemove: [1,2])
        var lbl = UILabel(frame: CGRectMake(20, 10, 100, 50))
        var filterVal : [Filter] = filters[selectedFilterCategory]! as [Filter]
        lbl.text = filterVal[indexPath.row].name
        lbl.sizeToFit()
        lbl.setNeedsDisplay()
        lbl.tag = 1
        cell.addSubview(lbl)
        
        var uncheckImg = UIImage(named: "uncheck")
        var recognizer = UITapGestureRecognizer(target: tar, action:Selector("tapDetected:"))
        var imgView = UIImageView(image: uncheckImg)
        imgView.frame.origin = CGPoint(x: UIScreen.mainScreen().bounds.size.width - 150, y: 8)
        imgView.userInteractionEnabled = true
        imgView.addGestureRecognizer(recognizer)
        imgView.tag = 2
        cell.addSubview(imgView)
    }
    
    class func GetCustomizedLabel(lbl: UILabel)-> UILabel{
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFontOfSize(12.0)
        lbl.sizeToFit()
        lbl.setNeedsDisplay()
        return lbl
    }
}