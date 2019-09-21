//
//  CategorySuggestionCell.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/20/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit
import TwitterKit

class CategorySuggestionCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    var viewController: CategorySuggestionViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        
        guard let vc: CategorySuggestionViewController = self.viewController else { fatalError() }
        
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
    
}
