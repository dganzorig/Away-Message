//
//  GradientView.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/3/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            self.updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            self.updateView()
        }
    }
    
    private func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map{$0.cgColor}
    }
}
