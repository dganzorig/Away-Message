//
//  SubmitSuggestionViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/24/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class SubmitSuggestionViewController: UIPageViewController, UITextViewDelegate {

    
    @IBOutlet weak var textView: UITextView!
    let placeholderText = "Enter here"
    let placeholderColor = UIColor.lightGray
    let typedColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.delegate = self
        self.setPlaceholderAttributes()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textView.textColor == self.placeholderColor {
            self.textView.text = nil
            self.textView.textColor = self.typedColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.textView.text.isEmpty {
            self.setPlaceholderAttributes()
        }
    }
    
    private func setPlaceholderAttributes() {
        self.textView.text = self.placeholderText
        self.textView.textColor = self.placeholderColor
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        // Do database call
    }
    
}
