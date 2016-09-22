//
//  BulletController.swift
//  Session1
//
//  Created by Apple on 9/22/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class PlayerBulletController : Controller {
    let SPEED : Double = 1000
    
    override func setup(parent: SKNode) -> Void {
        addFlyAction(parent)
        configurePhysics()
    }
    
    func configurePhysics() -> Void {
        self.view.physicsBody = SKPhysicsBody(rectangleOfSize: self.view.frame.size)
        
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_PLAYER_BULLET
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_ENEMY
    }
    
    // TODO
    func addFlyAction(parent: SKNode) -> Void {
        // 1
        let distanceToRoof = Double(parent.frame.height - self.view.frame.height)
        // 2
        let timeToReachRoof = distanceToRoof / SPEED
        
        // 3
        self.view.runAction(
            SKAction.sequence([
                    SKAction.moveToY(parent.frame.height, duration: timeToReachRoof),
                    SKAction.removeFromParent()
                ])
        )
    }
    
}
