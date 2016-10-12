//
//  ConfettiView.swift
//  Confetti
//
//  Created by Or on 04/10/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import UIKit

open class ConfettiView: UIView {

    open var isAnimating = true
    
    // MARK: Declarations
    var confettiLayers = [ConfettiLayer]()
    
    override open var bounds: CGRect {
        didSet {
            confettiLayers.forEach { layer in layer.resetBounderies() }
        }
    }
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        addConfetti()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        addConfetti()
    }
    
    
    // MARK: Confetti Methods
    private func addConfetti() {
        self.confettiLayers.append(ConfettiLayer(view: self))
        self.confettiLayers.append(ConfettiLayer(view: self, depth: 1.5))
        self.confettiLayers.append(ConfettiLayer(view: self, depth: 2))
    }
    
    
    // MARK: Touches
    override  open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override  open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override  open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // MARK: Controls
    
    /// Stops the animation of all layers
    open func stopAnimating() {
        isAnimating = false
        confettiLayers.forEach { layer in layer.invalidateTimer() }
    }
    
    open func startAnimating() {
        guard isAnimating == false else { return }
        isAnimating = true
        confettiLayers.forEach { layer in layer.setupTimerLoop() }
    }
    
    open func snapShot() {
        UIGraphicsBeginImageContext(self.frame.size);
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let data = UIImagePNGRepresentation(image!)
        let file = "\(NSDate()).png"
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file)
            print(path)
            //writing
            do {
                try data?.write(to: path!)
            }
            catch {/* error handling here */}
            
           
        }
    }
    
    
}
