//
//  XSwitchViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/16/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit
import Lottie

class XSwitchViewController: UIViewController {

    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.continueButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
            self.playAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.transition(with: self.directionsLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.directionsLabel.text = "Starting from the bottom of the screen:"
                }, completion: { (success) in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.25, execute: {
                        UIView.transition(with: self.directionsLabel, duration: 0.75, options: .transitionCrossDissolve, animations: {
                            self.directionsLabel.text = "Swipe up once with one finger"
                        }, completion: { (success) in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                UIView.transition(with: self.directionsLabel, duration: 0.75, options: .transitionCrossDissolve, animations: {
                                    self.directionsLabel.text = "And briefly hold until current-apps window is visible"
                                }, completion: { (success) in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                        UIView.transition(with: self.directionsLabel, duration: 0.75, options: .transitionCrossDissolve, animations: {
                                            self.directionsLabel.text = "Example:"
                                        }, completion: { (success) in
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                                UIView.transition(with: self.directionsLabel, duration: 0.85, options: .transitionCrossDissolve, animations: {
                                                    self.directionsLabel.text = "You can then swipe as needed and choose the desired app"
                                                }, completion: { (success) in
                                                    UIView.animate(withDuration: 0.75, animations: {
                                                        self.continueButton.alpha = 1
                                                    })
                                                })
                                            })
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            }
    }

    @IBAction func continuePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "to1", sender: self)
    }
    
    func playAnimation() {
        if let animation: Animation = Animation.named("X_iPhone") {
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.play()
        }
    }

}
