//
//  PopularSubmissionsCell.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/24/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit
import TwitterKit

class PopularSuggestionsCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    var viewController: PopularSuggestionsViewController?
    var suggestion: Suggestion? {
        didSet {
            updateCellUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.updateCellUI()
    }

    @IBAction func clipboardPressed(_ sender: UIButton) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = messageLabel.text
        self.viewController?.showToast(message: "Message copied to clipboard")
    }
    
    @IBAction func twitterPressed(_ sender: UIButton) {
        let store = TWTRTwitter.sharedInstance().sessionStore
        
        if store.session() == nil {
            TWTRTwitter.sharedInstance().logIn { (session, error) in
                if (session != nil) {
                    // Log-in successful, so compose the Tweet
                    self.composeTweet()
                } else {
                    // Error logging in
                    self.viewController?.showToast(message: "There was an error logging into your Twitter account")
                }
            }
        } else {
            // Already logged-in, so compose the Tweet
            self.composeTweet()
        }
    }
    
    // Assumption: TWTRTwitter has a valid session
    private func composeTweet() {
        let composer = TWTRComposer()
        
        guard let message: String = self.messageLabel.text else { fatalError() }
        let starterMessage: String = "Check out this away message I use for \(AppConstants.twitterHandle):\n\n\(message)"
        composer.setText(starterMessage)
        
        guard let vc: PopularSuggestionsViewController = self.viewController else { fatalError() }
        
        composer.show(from: vc, completion: { (result) in
            if (result == .done) {
                // Successfully composed tweet
                vc.showToast(message: "Successfully posted tweet")
            } else {
                // Canceled composing
                vc.showToast(message: "Canceled Twitter posting")
            }
        })
    }
    
    @IBAction func heartPressed(_ sender: UIButton) {
        let likeState = getLikeState()
        
        if likeState == .none {
            // person wants to like the message
            if let suggestion = suggestion {
                FirebaseService.incrementLike(docId: suggestion.docId) { (success) in
                    if (success) {
                        self.viewController?.showToast(message: "You have liked the suggestion")
                        RealmService.addLikedSuggestion(docId: suggestion.docId)
                    } else {
                        self.viewController?.showToast(message: "There was an error liking the suggestion")
                    }
                }
            }
        } else {
            // person wants to unlike the message
            if let suggestion = suggestion {
                FirebaseService.decrementLike(docId: suggestion.docId) { (success) in
                    if (success) {
                        self.viewController?.showToast(message: "You have unliked the suggestion")
                        RealmService.removeLikedSuggestion(docId: suggestion.docId)
                    } else {
                        self.viewController?.showToast(message: "There was an error unliking the suggestion")
                    }
                }
            }
        }
        
        self.updateCellUI()
    }
    
    private func getLikeState() -> LikeState {
        var likeState: LikeState = .none
        if let suggestion = self.suggestion {
            if RealmService.hasLikedSuggestion(docId: suggestion.docId) {
                likeState = .like
            }
        }
        return likeState
    }
    
    private func updateCellUI() {
        self.messageLabel.text = self.suggestion?.message ?? ""
        // solid heart only if Suggestion is set and Suggestion is in locally-saved liked messages
        let heartImageText = (suggestion != nil) && (RealmService.hasLikedSuggestion(docId: suggestion!.docId)) ? "" : ""
        heartButton.setTitle(heartImageText, for: .normal)
    }
    
}
