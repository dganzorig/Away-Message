//
//  EndViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/11/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.emojiLabel.alpha = 0
        self.backButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.emojiLabel.alpha = 0.6
            self.emojiLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.25, options: .curveEaseIn, animations: { () -> Void in
            self.emojiLabel.alpha = 1
            self.emojiLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseInOut, animations: {
            self.backButton.alpha = 1
        }, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
