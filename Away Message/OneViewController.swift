//
//  OneViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/10/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var settingsImage: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        self.oneLabel.alpha = 0
        self.openLabel.alpha = 0
        self.settingsImage.alpha = 0
        self.continueButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.oneLabel.alpha = 1
        }) { (success) in
            UIView.animate(withDuration: 0.75, animations: {
                self.openLabel.alpha = 1
                self.settingsImage.alpha = 1
            }, completion: { (success) in
                UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
                    self.continueButton.alpha = 1
                }, completion: nil)
            })
        }
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "to2", sender: self)
    }
    
}
