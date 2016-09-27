//
//  CGPointUtil.swift
//  Session1
//
//  Created by Apple on 9/4/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

extension CGPoint {
    func add(other : CGPoint) -> CGPoint {
        let retX = self.x + other.x
        let retY = self.y + other.y
        return CGPoint(x: retX, y: retY)
    }
    
    func subtract(other: CGPoint) -> CGPoint {
        return CGPoint(x: self.x - other.x, y: self.y - other.y)
    }
    
    func multiply(ratio : CGFloat) -> CGPoint {
        return CGPoint(x: x * ratio, y: y * ratio)
    }
    
    func distance(other: CGPoint) -> CGFloat {
        let dx = x - other.x
        let dy = y - other.y
        return sqrt(dx * dx + dy * dy)
    }
    
    func normalize() -> CGPoint {
        let length = sqrt(x * x + y * y)
        return CGPoint(x: x / length, y: y / length)
    }
}

extension SKAction {
    static func moveToBottom(y: CGFloat, speed: Double) -> SKAction {
        let timeToBottom = Double(y) / speed
        return SKAction.moveToY(0, duration: timeToBottom)
    }
    
    static func moveToTop(y: CGFloat, top: CGFloat, speed: Double) -> SKAction {
        let timeToTop = Double(top - y) / speed
        return SKAction.moveToY(top, duration: timeToTop)
    }
    
    static func repeatForeverWithDuration(secs: NSTimeInterval, block: () -> () ) -> SKAction {
        return SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(block),
                SKAction.waitForDuration(secs)
                ]))
    }
    
    
    
    
    
    
    
    
    
    
    
}
