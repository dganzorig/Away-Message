//
//  SixViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/11/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class SixViewController: UIViewController {

    @IBOutlet weak var sixLabel: UILabel!
    @IBOutlet weak var enterLabel: UILabel!
    @IBOutlet weak var screenshotImage: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var suggestionButton: UIButton!
    @IBOutlet weak var suggestionLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.sixLabel.alpha = 0
        self.enterLabel.alpha = 0
        self.screenshotImage.alpha = 0
        self.suggestionLabel.alpha = 0
        self.continueButton.alpha = 0
        
        // draw circle around suggestion button
        suggestionButton.bounds = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        suggestionButton.layer.borderWidth = 1.5
        suggestionButton.layer.backgroundColor = UIColor.clear.cgColor
        suggestionButton.layer.borderColor = AppConstants.defaultBlue.cgColor
        suggestionButton.layer.cornerRadius = 15.0
        
        // hide suggestion button
        let yTransform = -(suggestionButton.frame.origin.x + suggestionButton.frame.height)
        suggestionButton.transform = CGAffineTransform(translationX: 0, y: yTransform)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.sixLabel.alpha = 1
        }) { (success) in
            UIView.animate(withDuration: 0.5, animations: {
                self.enterLabel.alpha = 1
            }, completion: { (success) in
                UIView.animate(withDuration: 0.75, animations: {
                    self.screenshotImage.alpha = 1
                }, completion: { (success) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.suggestionLabel.alpha = 1
                    }, completion: { (success) in
                        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                            // move suggestion button back in
                            self.suggestionButton.transform = .identity
                        }, completion: nil)
                        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                            self.continueButton.alpha = 1
                        }, completion: nil)
                    })
                })
            })
        }
        
    }
    
    @IBAction func suggestionsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toCategories", sender: self)
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toEnd", sender: self)
    }

}
