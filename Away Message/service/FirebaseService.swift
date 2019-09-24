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
    
    static func addSuggestion(message: String) -> Error? {
        var error: Error? = nil
        db.collection(suggestionCollectionString).document().setData([
            "dateCreated": Timestamp(),
            "likes": 0,
            "message": message,
        ]) { err in
            error = err
        }
        return error
    }
    
    static func getAllSuggestions(completionHandler: @escaping (_ suggestions: [Suggestion]?) -> ())  {
        var suggestions: [Suggestion]?
        db.collection(suggestionCollectionString).getDocuments { (querySnapshot, err) in
            if err == nil {
                if let snapshot = querySnapshot {
                    suggestions = snapshot.documents.map({ (doc) -> Suggestion in
                        let docId: String = doc.documentID
                        let newSuggestion = Suggestion(docId: docId, data: doc.data())
                        return newSuggestion
                    })
                    // completionHandler(suggestions)
                }
            }
            completionHandler(suggestions)
        }
    }
    
}
