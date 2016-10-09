//
//  ShapeView.swift
//  Confetti
//
//  Created by Or on 30/09/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import UIKit
import CoreGraphics

// MARK: ShapeType


/// Enum to describes the possible shaps
enum ShapeType {
    
    ///Defines the possible colors of the confetti
    var possibleColors:[UIColor] {
        get {
            return [#colorLiteral(red: 0, green: 0.4443781972, blue: 0.8679092526, alpha: 1),#colorLiteral(red: 0.5667363405, green: 0.8658216596, blue: 0.4901404977, alpha: 1),#colorLiteral(red: 1, green: 0.9203848839, blue: 0.331726253, alpha: 1),#colorLiteral(red: 0.9978461862, green: 0.3002898395, blue: 0.2846045196, alpha: 1),#colorLiteral(red: 0.7954284549, green: 0.3837707639, blue: 0.7679683566, alpha: 1)]
        }
    }
    
    case circle
    case triangle
    case square
    case squigle
    
    
    /**
        Depends on the enum returns draw clousre
        - Returns: A draw clousure that is adaptable to size and color
        - Attention: The returned clousre is intented to be called inside of draw rect
     */
    
    func getDrawfunction() -> ((CGRect,UIColor)->()) {
        switch self {
        case .circle:
            return { rect,color in
                let path = UIBezierPath(ovalIn: rect)
                color.setFill()
                path.fill()
            }
        case .square:
            return { rect,color in
                let path = UIBezierPath(rect: rect)
                color.setFill()
                path.fill()
            }
        case .triangle:
            return { rect,color in
                let path = UIBezierPath()
                path.move(to: CGPoint(x:0, y: rect.size.width))
                path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
                path.addLine(to: CGPoint(x: rect.size.width/2, y: 0))
                path.addLine(to: CGPoint(x:0, y: rect.size.width))
                color.setFill()
                path.fill()
            }
        case .squigle:
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
    
    /// Returns a random color
    func getRandomColor() -> UIColor {
        return possibleColors.randomElement()!
    }
    
    /// Returns a randum ShapeType
    static func random()-> ShapeType {
        return [ShapeType.circle,ShapeType.square,.triangle,.squigle].randomElement()!
    }
}

// MARK: ShapeView

/// UIView subclass which is initialized with a random Shape and color
class ShapeView: UIView {
    
    
    /// The shape that will be draw in the view. *This cannot change*
    let shapeType:ShapeType
    /// The color of the shape that will be drawen in the view. *This cannot change*
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
 
    /**
      Initialize a new shape view with random shape and color
        
     - Parameters:
        - center: The center position of the initiaized view
        - depth: The wanted depth, this causes the shape to move faster and apear smaller to create the illusion of depth *Default Value is 1*
     */
    convenience init(center point:CGPoint, depth:Double = 1) {
        self.init(frame:CGRect(x: 0, y: 0, width: 20/depth, height: 20/depth))
        self.center = point
    }
    
   
    

}

extension Collection where Index == Int {
    /// Returns random elemnt from an array
    func randomElement() -> Iterator.Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(endIndex)))]
    }
    
}
