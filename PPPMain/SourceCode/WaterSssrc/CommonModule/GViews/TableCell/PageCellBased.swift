//
//  PageCellBased.swift
//  tripbay_ios
//
//  Created by Rock on 2019/8/6.
//  Copyright © 2019 TripBay. All rights reserved.
//

import UIKit

class PageCellBased: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let margin: Float = 16.0
    fileprivate let space: Float = 8.0
    fileprivate var itemSize = UIScreen.main.bounds.size
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        itemSize.width = collectionView.frame.size.width + 10//CGFloat(itemSize.width) - CGFloat(margin * 2.0)
        itemSize.height = collectionView.frame.size.height
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = itemSize
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension PageCellBased: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset:
        UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(itemSize.width) + space
        let currentOffset = Float(scrollView.contentOffset.x)
        let targetOffset = Float(targetContentOffset.pointee.x)
        var newTargetOffset = Float(0.0)
        
        if targetOffset > currentOffset {
            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
        } else {
            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
        }
        
        if newTargetOffset < 0.0 {
            newTargetOffset = 0.0
        } else if (CGFloat(newTargetOffset) > scrollView.contentSize.width) {
            newTargetOffset = Float(scrollView.contentSize.width)
        }
        
        targetContentOffset.pointee.x = CGFloat(currentOffset)
        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: 0.0), animated: true)
    }
}
