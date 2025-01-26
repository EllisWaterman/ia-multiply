//
//  Item.swift
//  ia-multiply
//
//  Created by ellis on 1/26/25.
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
