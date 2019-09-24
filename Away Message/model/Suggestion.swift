//
//  Suggestion.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/24/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import Foundation
import Firebase

struct Suggestion {
    
    var dateCreated: Date?
    var docId: String
    var likes: Int?
    var message: String?
    
    init(docId: String, data: [String: Any]) {
        let dateCreatedTimestamp: Timestamp? = data["dateCreated"] as! Timestamp?
        self.dateCreated = dateCreatedTimestamp?.dateValue()
        self.docId = docId
        self.likes = data["likes"] as! Int?
        self.message = data["message"] as! String?
    }
    
}
