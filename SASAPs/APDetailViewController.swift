//
//  APDetailViewController.swift
//  SASAPs
//
//  Created by Ankur Gandhi on 8/19/14.
//  Copyright (c) 2014 ccap. All rights reserved.
//

import UIKit

class APDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, APIControllerProtocol{
    
    @IBOutlet weak var apImageView: UIImageView!
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!

    var imageWidth: CGFloat = 0
    var imagePadding: CGFloat = 20
    var thumbnailStripeHeight: CGFloat = 100
    var backColor: UIColor = UIColor.whiteColor()
    var currentPage: Int = 0
    var apImageDataSource = [APPhoto]()
    let thumbCellIdentifier: String = "thumbCell"
    var thumbnailImageCache : Dictionary<String, UIImage> = Dictionary<String,UIImage>()
    var bigImageCache : Dictionary<String, UIImage> = Dictionary<String,UIImage>()
    var selectedAupairId : String = ""
    var api = APIController()
    var didCellSelected: Bool = false
    var lastSelectedImageIndexPath: NSIndexPath? = nil
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        loadingIndicator.startAnimating()
        //println(selectedAupairId)
        api.get(UtilityController.APIURL + "/api/IOSApi/GetAupairPhotos?aupairkey=" + selectedAupairId)
        api.delegate = self
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell? = collectionView.dequeueReusableCellWithReuseIdentifier(thumbCellIdentifier, forIndexPath: indexPath) as? UICollectionViewCell
        
        if(cell == nil){
            cell = UICollectionViewCell()
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            var apPhotoObj = self.apImageDataSource[indexPath.row]
            if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath){
                var imgView: UIImageView = cellToUpdate.viewWithTag(2) as UIImageView
                imgView.layer.cornerRadius = 3.0;
                imgView.layer.borderColor = UIColor.grayColor().CGColor
                imgView.layer.borderWidth = 2.0
                imgView.contentMode = UIViewContentMode.ScaleToFill
                imgView.image = apPhotoObj.thumbnailPhoto

                if(indexPath.row == 0 && !self.didCellSelected){
                    self.apImageView.image = apPhotoObj.bigPhoto
                    self.lastSelectedImageIndexPath = indexPath
                    self.SelectCurrentImage(indexPath, unselectLastImage: false)
                }
            }

        })
        
        return cell!
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apImageDataSource.count
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView!, shouldSelectItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        self.didCellSelected = true
        self.thumbnailCollectionView.deselectItemAtIndexPath(indexPath, animated: false)
        self.apImageView.contentMode = UIViewContentMode.ScaleToFill
        self.apImageView.image = apImageDataSource[indexPath.row].bigPhoto
        SelectCurrentImage(indexPath,unselectLastImage: true)
        self.lastSelectedImageIndexPath = indexPath
        
        if(indexPath.row > 0){
            var indexRow = indexPath.row + 1
            if(indexPath.row == apImageDataSource.count - 1){
                indexRow = indexPath.row
            }
            self.thumbnailCollectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: indexRow, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        }
        
    }
    
    func SelectCurrentImage(indexPath: NSIndexPath, unselectLastImage: Bool){
        var cell: UICollectionViewCell = self.thumbnailCollectionView.cellForItemAtIndexPath(indexPath) as UICollectionViewCell!
        
        var imgView : UIImageView = cell.viewWithTag(2) as UIImageView
        imgView.layer.borderWidth = 2
        imgView.layer.borderColor = UIColor.redColor().CGColor
        
        if(unselectLastImage ){
            if(lastSelectedImageIndexPath? != nil  && indexPath.compare(self.lastSelectedImageIndexPath!) != NSComparisonResult.OrderedSame){
                if let lastcell = self.thumbnailCollectionView.cellForItemAtIndexPath(lastSelectedImageIndexPath!){
                    imgView = lastcell.viewWithTag(2) as UIImageView
                    imgView.layer.cornerRadius = 3.0;
                    imgView.layer.borderColor = UIColor.grayColor().CGColor
                    imgView.layer.borderWidth = 2.0
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0,0,0,0)
    }
    
 
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 80)
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView!) {
        scrollView.userInteractionEnabled = false
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool) {
        return
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        //return
        scrollView.userInteractionEnabled = true
    }
    
    
    func didReceiveAPIResults(results: AnyObject) {
        apImageDataSource = APPhoto.photosWithJSON(results as NSArray)
        dispatch_async(dispatch_get_main_queue(), {
            self.thumbnailCollectionView.reloadData()
            self.loadingIndicator.stopAnimating()
        })
    }

}
