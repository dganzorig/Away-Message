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

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.alpha = 0
        self.continueButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
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
