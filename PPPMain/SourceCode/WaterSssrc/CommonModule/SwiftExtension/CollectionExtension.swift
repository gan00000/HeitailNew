//
//  CollectionExtension.swift
//  tripbay_ios
//
//  Created by Johnny on 2020/2/17.
//  Copyright © 2020 TripBay. All rights reserved.
//

import Foundation

public extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Array {
    
    subscript (exist index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
