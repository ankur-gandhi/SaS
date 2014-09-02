//
//  APPhotoController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/22/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation
import UIKit

class APPhotoController:DKImageBrowser{

    override func viewDidLoad() {
        super.viewDidLoad()
        actionCustom()
    }
    
    func actionCustom() {
        var apImageDataSource : [String] = [String]()
        var imgHeight: CGFloat = 416
        var imgWidth: CGFloat = self.view.bounds.size.width - 20
        for var i = imgWidth; i < imgWidth+10; i++ {
            //var placeKitten : String = "http://placekitten.com/\(Int(i*1.1))/\(Int(imgHeight))"
            
            var placeKitten: String = "http://dev-sas.culturalcare.com/GetImage.ashx?w=200&h=300&p=http://documents.culturalcare.com/APPhotos/Active/ATV0082103699521795604_635254576349273000..JPG"
            
            apImageDataSource.append(placeKitten)
        }
        
        self.DKImageDataSource = apImageDataSource
        self.DKImageWidth = imgWidth
        self.DKImagePadding = 20
        self.DKThumbnailStripHeight = 100
    }

}