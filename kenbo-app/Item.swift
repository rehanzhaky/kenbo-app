//
//  Item.swift
//  kenbo-app
//
//  Created by Raihan Zhaky Al Hafizh on 11/03/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
