//
//  File.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/19/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import Foundation

// Singleton class for app constants
class AppConstants {
    
    static let awayMessageDict: Dictionary<String, CategoryEntry> = [
        "General": CategoryEntry(category: "General", emoji: "💬", messages: [
                "I am currenty Signed📴 and will get back to you as soon as I can :)",
                "Hiya! Sorry in advance if this message gives you false hopes of a swift and enthusiastic response, but I'm away for a while and will get back to you as soon as possible!",
                "I can't answer right away at the moment, but in the meantime, you should consider joining the movement @SignOffTogether"
            ]),
        "Vacation": CategoryEntry(category: "Vacation", emoji: "🌴", messages: [
                "I am currently on vacation and will get back to you as soon as I can :)",
                "I'm well out of town on vacation for a bit but will get back to you when I come back!"
            ])
    ]
    
}
