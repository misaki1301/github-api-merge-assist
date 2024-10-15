//
//  Item.swift
//  github-merge
//
//  Created by Paul Pacheco on 13/10/24.
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
