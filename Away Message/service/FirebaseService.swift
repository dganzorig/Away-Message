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
    
    static func getAllSuggestions(completionHandler: @escaping (_ suggestions: [Suggestion]?) -> ()) {
        var suggestions: [Suggestion]?
        db.collection(suggestionCollectionString).getDocuments { (querySnapshot, err) in
            if err == nil {
                if let snapshot = querySnapshot {
                    suggestions = snapshot.documents.map({ (doc) -> Suggestion in
                        let docId: String = doc.documentID
                        let newSuggestion = Suggestion(docId: docId, data: doc.data())
                        return newSuggestion
                    })
                }
            }
            completionHandler(suggestions)
        }
    }
    
    static func getSuggestion(docId: String, completionHandler: @escaping (_ suggestion: Suggestion?) -> ()) {
        var suggestion: Suggestion?
        let docRef: DocumentReference = db.collection(suggestionCollectionString).document(docId)
        docRef.getDocument { (querySnapshot, err) in
            if let snapshot = querySnapshot, snapshot.exists {
                let data = snapshot.data()!
                suggestion = Suggestion(docId: docId, data: data)
            }
            completionHandler(suggestion)
        }
    }
    
    static func updateSuggestion(newSuggestion: Suggestion, completionHandler: @escaping (_ success: Bool) -> ()) {
        let docRef: DocumentReference = db.collection(suggestionCollectionString).document(newSuggestion.docId)
        docRef.setData([
            "dateCreated": newSuggestion.dateCreated as Any,
            "likes": newSuggestion.likes as Any,
            "message": newSuggestion.message as Any
        ]) { (error) in
            completionHandler(error == nil)
        }
    }
    
    static func incrementLike(docId: String, completionHandler: @escaping (_ success: Bool) -> ())  {
        getSuggestion(docId: docId) { (suggestion) in
            var successResult = false
            if var suggestion = suggestion {
                let newCount = suggestion.likes! + 1
                suggestion.likes = newCount
                updateSuggestion(newSuggestion: suggestion, completionHandler: { (success) in
                    successResult = success
                    completionHandler(successResult)
                })
            } else {
                completionHandler(false)
            }
        }
    }
    
    static func decrementLike(docId: String, completionHandler: @escaping (_ success: Bool) -> ()) {
        getSuggestion(docId: docId) { (suggestion) in
            var successResult = false
            if var suggestion = suggestion {
                let newCount = suggestion.likes! - 1
                suggestion.likes = newCount
                updateSuggestion(newSuggestion: suggestion, completionHandler: { (success) in
                    successResult = success
                    completionHandler(successResult)
                })
            } else {
                completionHandler(false)
            }
        }
    }
    
}
