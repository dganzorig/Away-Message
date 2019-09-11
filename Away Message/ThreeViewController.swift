//
//  ThreeViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/11/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class ThreeViewController: UIViewController {

    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var screenshotImage: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.threeLabel.alpha = 0
        self.turnLabel.alpha = 0
        self.screenshotImage.alpha = 0
        self.continueButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.threeLabel.alpha = 1
        }) { (success) in
            UIView.animate(withDuration: 0.5, animations: {
                self.turnLabel.alpha = 1
            }, completion: { (success) in
                UIView.animate(withDuration: 0.75, animations: {
                    self.screenshotImage.alpha = 1
                }, completion: { (success) in
                    UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
                        self.continueButton.alpha = 1
                    }, completion: nil)
                })
            })
        }
    }

    @IBAction func continuePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "to4", sender: self)
    }
    
}
