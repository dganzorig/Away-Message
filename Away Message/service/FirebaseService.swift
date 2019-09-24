//
//  firebase.swift
//  Away Message
//

//  Created by Dona Ganzorig on 9/24/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

class FirebaseService {
    
    static let db = Firestore.firestore()
    static let suggestionCollectionString: String = "Suggestions"
    
    static func addSuggestion(message: String) {
        db.collection(suggestionCollectionString).document().setData([
            "dateCreated": Timestamp(),
            "likes": 0,
            "message": message,
        ]) { err in
            if let err = err {
                print("Error writing data: \(err)")
            } else {
                print("Document successfully written")
            }
        }
    }
    
}
