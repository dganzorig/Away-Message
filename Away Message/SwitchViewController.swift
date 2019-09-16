//
//  SwitchViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/15/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit
import Lottie

class SwitchViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.directionsLabel.alpha = 0
        self.continueButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.directionsLabel.alpha = 1
        }) { (success) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                UIView.transition(with: self.directionsLabel, duration: 0.75, options: .transitionCrossDissolve, animations: {
                    self.directionsLabel.text = "To do so, first double click the 'Home' button below the screen"
                }, completion: { (success) in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.playAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            UIView.transition(with: self.directionsLabel, duration: 0.75, options: .transitionCrossDissolve, animations: {
                                self.directionsLabel.text = "Then, swipe between and choose app windows as needed"
                            }, completion: { (success) in
                                UIView.animate(withDuration: 0.75, animations: {
                                    self.continueButton.alpha = 1
                                })
                            })
                        }
                    })
                })
            }
        }
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "to1", sender: self)
    }
    
    func playAnimation() {
        if let animation: Animation = Animation.named("Old_iPhone") {
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.play()
        }
    }

}
