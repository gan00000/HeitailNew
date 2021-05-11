//
//  CellOfIdentifier.swift
//  tripbay_ios
//
//  Created by Rock on 2019/8/5.
//  Copyright © 2019 TripBay. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class var identifier: String {
        get {
            return String(describing: self)
        }
    }
}

extension UICollectionViewCell {
    class var identifier: String {
        get {
            return String(describing: self)
        }
    }
}

extension UITableViewHeaderFooterView {
    class var identifier: String {
        get {
            return String(describing: self)
        }
    }
}

//extension UICollectionReusableView {
//    class var identifier: String {
//        get {
//            return String(describing: self)
//        }
//    }
//}
