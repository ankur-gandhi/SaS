//
//  ResultFilterCount.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 9/5/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

class FilterResult: JSONModel{
    var isFemale: NSArray?
    var preferredGA: NSArray?
    var regionId: NSArray?
    var countryId: NSArray?
    var actualEnglishLevel: NSArray?
    var hasVideo: NSArray?
    var childExp: NSArray?
    var apLanguages: NSArray?
    var religion: NSArray?
    var swimmingSkill: NSArray?
    var hasBoyGirlFriend: NSArray?
    var hasTatooPierc: NSArray?
    var ageGroupCared: NSArray?
    var typeOfAupair: NSArray?
    var extensionLength: NSArray?
    var isInfantQualified: NSArray?
    var isSpecialNeedQualified: NSArray?
    var noOfKids: NSArray?
    var isCatOk: NSArray?
    var isDogOk: NSArray?
    var isSingleMotherOk: NSArray?
    var isSingleFatherOk: NSArray?
    var sameSexCoupleOk: NSArray?
    var livedAwayFromHome: NSArray?
    var hasSiblings: NSArray?
    var specialDiet: NSArray?
    var status: NSArray?
    var drivingLicenseFor: NSArray?
    var ageOnArrival: NSArray?
    var profileCreated: NSArray?
    var lengthOfStay: NSArray?
}

class FilterResultModel{
    
    var Id : String
    var Count: Int
    
    init(obj: AnyObject){
        self.Id = obj["Id"] as String
        self.Count = obj["Count"] as Int
    }
}