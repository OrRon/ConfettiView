//
//  ConfettiLayer.swift
//  Confetti
//
//  Created by Or on 04/10/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

class ConfettiLayer {
    
    let view:UIView
    var animator:UIDynamicAnimator
    var itemBehavior = UIDynamicItemBehavior()
    var motionManager = CMMotionManager()
    var collisions = UICollisionBehavior()
    var baseVelocity = CGPoint(x:0,y:200.0)
    var calculatedVelocity:CGPoint
    var totalTilt = 1.0
    var depth:Double
    
    init(view aView:UIView, depth aDepth:Double = 1.0) {
        view = aView
        animator = UIDynamicAnimator(referenceView: view)
        calculatedVelocity = baseVelocity
        depth = aDepth
        baseVelocity = CGPoint(x: baseVelocity.x / CGFloat(depth), y: baseVelocity.y / CGFloat(depth))
        
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates()
        }
        
        setupBehiviors()
        setupTimerLoop()
    }
    
    func setupBehiviors() {
        
        collisions.collisionMode = .boundaries
        resetBounderies()
        
        itemBehavior.allowsRotation = true
        itemBehavior.friction = 0.0
        itemBehavior.resistance = 0
        itemBehavior.elasticity = 0
        
        
        animator.addBehavior(itemBehavior)
        animator.addBehavior(collisions)
    }
    
    func resetBounderies() {
        collisions.removeAllBoundaries()
        collisions.addBoundary(withIdentifier: "left" as NSCopying, from: CGPoint(x:0,y:0), to: CGPoint(x:0,y:self.view.bounds.size.height))
        collisions.addBoundary(withIdentifier: "right" as NSCopying, from: CGPoint(x:self.view.bounds.size.width,y:0), to: CGPoint(x:self.view.bounds.size.width,y:self.view.bounds.size.height))
        
    }
    
    func setupTimerLoop() {
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.randomlyAddParticle()
                if let accelerometerData = self.motionManager.accelerometerData {
                    self.updateCurrentState(accelerometerData: accelerometerData)
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func updateCurrentState(accelerometerData:CMAccelerometerData)  {
        self.totalTilt = -accelerometerData.acceleration.y
        self.calculatedVelocity = CGPoint(x: self.baseVelocity.x + CGFloat(accelerometerData.acceleration.x * 200 / self.depth), y:  CGFloat(-accelerometerData.acceleration.y*300 / self.depth))
        self.itemBehavior.items.forEach{ item in
            let vel = self.itemBehavior.linearVelocity(for: item)
            let delta = CGPoint(x:self.calculatedVelocity.x - vel.x,y:self.calculatedVelocity.y - vel.y)
            self.itemBehavior.addLinearVelocity(delta, for: item)
            if let view = item as? UIView {
                if view.frame.origin.y > self.view.frame.size.height {
                    self.collisions.removeItem(item)
                    self.itemBehavior.removeItem(item)
                    view.removeFromSuperview()
                }
                
            }
        }
    }
    
    func randomlyAddParticle() {
        //Add particle in dependency to the tilt of the device to more tilted it is less chance to add another partical
        let chance = Double(arc4random_uniform(UInt32(100)))
        if  chance < self.totalTilt * 80 {
            let randX = Int(arc4random_uniform(UInt32(380)))
            self.addParticle(at: CGPoint(x: randX, y: -50))
        }
    }
    
    func addParticle(at point:CGPoint) {
        let shapeView = ShapeView(center: point,depth:self.depth)
        
        self.view.addSubview(shapeView)
        let precentage =  Double(arc4random_uniform(UInt32(101)))/100.0
        shapeView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI*precentage))
        
        collisions.addItem(shapeView)
        itemBehavior.addItem(shapeView)
        itemBehavior.addLinearVelocity(calculatedVelocity, for: shapeView)
        let spin = Int(arc4random_uniform(UInt32(100)))
        
        if spin > 80 {
            itemBehavior.addAngularVelocity(CGFloat(M_PI), for: shapeView)
        }
        
    }
    
    
}
