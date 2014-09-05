//
//  Filter.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 9/2/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

func == (lhs: Filter, rhs: Filter) -> Bool{
    return lhs.value == rhs.value
}

class Filter: Equatable{
    var name: String
    var value: String
    
    init(name:String, value:String){
        self.name = name
        self.value = value
    }

}