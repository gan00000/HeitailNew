//
//  TableCellable.swift
//  tripbay_ios
//
//  Created by Rock on 2019/8/6.
//  Copyright © 2019 TripBay. All rights reserved.
//

import UIKit

protocol TableCellable {
    associatedtype CellType
    
    var setup: ((CellType, IndexPath) -> Void)? { get set }
    var numberOfItemSection: (() -> Int)? { get set }
    var didSelectItemAt: ((IndexPath) -> Void)? { get set }
    var didDidEndScroll: ((CGPoint) -> Void)? { get set }
}
