//
//  CategoryEntry.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/19/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import Foundation

struct CategoryEntry {
    
    var category: String = ""
    var emoji: String = ""
    var messages: [String] = []
    
    init(category: String, emoji: String, messages: [String]) {
        self.category = category
        self.emoji = emoji
        self.messages = messages
    }
    
}
