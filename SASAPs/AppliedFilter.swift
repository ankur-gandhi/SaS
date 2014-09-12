//
//  AppliedFilter.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 9/5/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

class AppliedFilter: NSObject, Equatable{
    var AgeOfAP: String?
    var Gender: String?
    
    override init(){
        super.init()
    }
}

func == (lhs: AppliedFilter, rhs: AppliedFilter) -> Bool{
    
    return lhs.AgeOfAP? == rhs.AgeOfAP? &&
           lhs.Gender? == rhs.Gender?
}