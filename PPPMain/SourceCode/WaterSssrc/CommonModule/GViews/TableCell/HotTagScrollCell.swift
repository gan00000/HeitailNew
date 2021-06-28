//
//  HotTagScrollCell.swift
//  tripbay_ios
//
//  Created by gama on 2021/3/1.
//  Copyright © 2021 TripBay. All rights reserved.
//

import UIKit

class HotTagScrollCell: UITableViewCell {
    
    var setup: ((HotTagCell, IndexPath) -> Void)?
    var numberOfItemSection: (() -> Int)?
    var didSelectItemAt: ((IndexPath) -> Void)?
    var didDidEndScroll: ((CGPoint) -> Void)?
    var didEndDisplaying: ((Int) -> Void)?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(HotTagCell.loadNib(), forCellWithReuseIdentifier: HotTagCell.identifier)
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth: CGFloat = (ScreenWidth - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumLineSpacing) / 2
        let itemSize: CGSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.itemSize = itemSize
        
        collectionViewHeight.constant = itemSize.height + flowLayout.sectionInset.top + flowLayout.sectionInset.bottom
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setup = nil
        numberOfItemSection = nil
        didSelectItemAt = nil
        didDidEndScroll = nil
    }
    
}

extension HotTagScrollCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callback = didSelectItemAt {
            callback(indexPath)
        }
    }
    
}

extension HotTagScrollCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = numberOfItemSection {
            return count()
        } else {
            return 0
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotTagCell.identifier, for: indexPath) as! HotTagCell
        if let setup = setup {
            setup(cell, indexPath)
        }
        return cell
    }
    
}

extension HotTagScrollCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let callback = didDidEndScroll {
            callback(scrollView.contentOffset)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            if let callback = didDidEndScroll {
                callback(scrollView.contentOffset)
            }
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset:
        UnsafeMutablePointer<CGPoint>) {
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let pageWidth = flowLayout.itemSize.width + flowLayout.minimumLineSpacing
        let currentOffset = scrollView.contentOffset.x
        let targetOffset = targetContentOffset.pointee.x
        var newTargetOffset: CGFloat = 0.0
        
        if targetOffset > currentOffset {
            newTargetOffset = ceil(currentOffset / pageWidth) * pageWidth
        } else {
            newTargetOffset = floor(currentOffset / pageWidth) * pageWidth
        }
        
        if newTargetOffset < 0.0 {
            newTargetOffset = 0.0
        } else if (newTargetOffset > scrollView.contentSize.width) {
            newTargetOffset = scrollView.contentSize.width
        }
        
        targetContentOffset.pointee.x = currentOffset
        
        let page = newTargetOffset / pageWidth
        if let callback = didEndDisplaying {
            callback(Int(page))
        }

        scrollView.setContentOffset(CGPoint(x: newTargetOffset, y: 0.0), animated: true)
    }

}
