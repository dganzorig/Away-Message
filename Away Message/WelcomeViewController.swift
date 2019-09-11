//
//  ViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/2/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var awayMessageLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.welcomeLabel.alpha = 0
        self.awayMessageLabel.alpha = 0
        self.continueButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0.25, options: [], animations: {
            self.welcomeLabel.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.75, delay: 1.25, options: [], animations: {
            self.awayMessageLabel.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.75, delay: 2.25, options: .curveEaseInOut, animations: {
            self.continueButton.alpha = 1
        }, completion: nil)
        
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "to1", sender: self)
    }
    
}

