//
//  CGPointUtil.swift
//  Session1
//
//  Created by Apple on 9/4/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import Foundation

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
    
    // func multiply
    // func distance
    // func normalize
}
