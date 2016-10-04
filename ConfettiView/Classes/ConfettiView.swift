//
//  ConfettiView.swift
//  Confetti
//
//  Created by Or on 04/10/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import UIKit

class ConfettiView: UIView {

    
    var confettiLayers = [ConfettiLayer]()
    
    override var bounds: CGRect {
        didSet {
            confettiLayers.forEach { layer in layer.resetBounderies() }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConfetti()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addConfetti()
    }
    
    
    
    func addConfetti() {
        self.confettiLayers.append(ConfettiLayer(view: self))
        self.confettiLayers.append(ConfettiLayer(view: self, depth: 1.5))
        self.confettiLayers.append(ConfettiLayer(view: self, depth: 2))
    }
    
    
}
