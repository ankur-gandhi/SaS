//
//  APPhoto.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/29/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import Foundation

class APPhoto{
    var thumbnailUrl: String
    var photoUrl : String
    var caption: String
    var thumbnailPhoto: UIImage
    var bigPhoto : UIImage
    
    init(thumbnailUrl: String, photoUrl: String, caption: String, thumbnailPhoto: UIImage, bigPhoto : UIImage){
        self.thumbnailUrl = thumbnailUrl
        self.photoUrl = photoUrl
        self.caption = caption
        self.thumbnailPhoto = thumbnailPhoto
        self.bigPhoto = bigPhoto
    }
    
    class func photosWithJSON(allResults: NSArray) -> [APPhoto] {
        
        var photos = [APPhoto]()
        
        if allResults.count>0 {
            for photoInfo in allResults {
                //println(photoInfo["ThumbnailPhotoUrl"])
                var imageData = NSData(contentsOfURL: NSURL(string: photoInfo["ThumbnailPhotoUrl"] as String))
                //println(imageData)
                var image = UIImage(data: imageData)
                //var bigImage = UIImage(data: NSData(contentsOfURL: NSURL(string: photoInfo["PhotoUrl"] as String)))
                //println(image)
                var photo = APPhoto(thumbnailUrl: photoInfo["ThumbnailPhotoUrl"] as String, photoUrl: photoInfo["PhotoUrl"] as String, caption: photoInfo["Caption"] as String, thumbnailPhoto: image, bigPhoto: image)
                photos.append(photo)
            }
        }
        return photos
    }
}
