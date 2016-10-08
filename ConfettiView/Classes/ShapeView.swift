//
//  ShapeView.swift
//  Confetti
//
//  Created by Or on 30/09/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import UIKit
import CoreGraphics

enum ShapeType {
    
    var possibleColors:[UIColor] {
        get {
            return [#colorLiteral(red: 0, green: 0.4443781972, blue: 0.8679092526, alpha: 1),#colorLiteral(red: 0.5667363405, green: 0.8658216596, blue: 0.4901404977, alpha: 1),#colorLiteral(red: 1, green: 0.9203848839, blue: 0.331726253, alpha: 1),#colorLiteral(red: 0.9978461862, green: 0.3002898395, blue: 0.2846045196, alpha: 1),#colorLiteral(red: 0.7954284549, green: 0.3837707639, blue: 0.7679683566, alpha: 1)]
        }
    }
    
    case Circle
    case Triangle
    case Square
    case Squigle
    
    func getDrawfunction() -> ((CGRect,UIColor)->()) {
        switch self {
        case .Circle:
            return { rect,color in
                let path = UIBezierPath(ovalIn: rect)
                color.setFill()
                path.fill()
            }
        case .Square:
            return { rect,color in
                let path = UIBezierPath(rect: rect)
                color.setFill()
                path.fill()
            }
        case .Triangle:
            return { rect,color in
                let path = UIBezierPath()
                path.move(to: CGPoint(x:0, y: rect.size.width))
                path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
                path.addLine(to: CGPoint(x: rect.size.width/2, y: 0))
                path.addLine(to: CGPoint(x:0, y: rect.size.width))
                color.setFill()
                path.fill()
            }
        case .Squigle:
            return { rect,color in
                let path = UIBezierPath()
                path.move(to: CGPoint(x:5, y: 5))
                path.addCurve(to: CGPoint(x:rect.size.width-5,y:rect.size.width-5),
                              controlPoint1: CGPoint(x:0,y:rect.size.width),
                              controlPoint2: CGPoint(x:rect.size.width,y:0))
                path.lineWidth = 2.0
                color.setStroke()
                path.stroke()
            }
        }
    }
    func getRandomColor() -> UIColor {
        return possibleColors.randomElement()!
    }
    static func random()-> ShapeType {
        return [ShapeType.Circle,ShapeType.Square,.Triangle,.Squigle].randomElement()!
    }
}



class ShapeView: UIView {
    
    
    
    let shapeType:ShapeType
    let shapeColor:UIColor
    
    // MARK: life cycle
    
    override func draw(_ rect: CGRect) {
        let drawFunction = shapeType.getDrawfunction()
        drawFunction(rect,shapeColor)
    }

    override init(frame: CGRect) {
        shapeType = ShapeType.random()
        shapeColor = shapeType.getRandomColor()
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    convenience init(center point:CGPoint, depth:Double = 1) {
        self.init(frame:CGRect(x: 0, y: 0, width: 20/depth, height: 20/depth))
        self.center = point
    }
    
   
    

}

extension Collection where Index == Int {
    
    func randomElement() -> Iterator.Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(endIndex)))]
    }
    
}
