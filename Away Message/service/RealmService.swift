//
//  RealmService.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/24/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    static let realm = try! Realm()
    
    static func getLikedSuggestions() -> [RealmSuggestion] {
        let likedSuggestions: [RealmSuggestion] = Array(realm.objects(RealmSuggestion.self))
        return likedSuggestions
    }
    
    static func likedSuggestionInstances(docId: String) -> Int {
        let queryResult: Results<RealmSuggestion> = realm.objects(RealmSuggestion.self).filter("docId = '\(docId)'")
        let resultCount = queryResult.count
        return resultCount
    }
    
    static func hasLikedSuggestion(docId: String) -> Bool {
        let resultCount = likedSuggestionInstances(docId: docId)
        return resultCount > 0
    }
    
    static func addLikedSuggestion(docId: String) {
        guard likedSuggestionInstances(docId: docId) == 0 else { return }
        let newSuggestion: RealmSuggestion = RealmSuggestion()
        newSuggestion.docId = docId
        try! realm.write {
            realm.add(newSuggestion)
        }
    }
    
    static func removeLikedSuggestion(docId: String) {
        guard likedSuggestionInstances(docId: docId) > 0 else { return }
        let queryResults: Results<RealmSuggestion> = realm.objects(RealmSuggestion.self).filter("docId = '\(docId)'")
        try! realm.write {
            realm.delete(queryResults)
        }
    }
    
}
