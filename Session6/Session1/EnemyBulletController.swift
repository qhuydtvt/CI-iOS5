//
//  EnemyBulletController.swift
//  Session1
//
//  Created by Apple on 9/25/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class EnemyBulletController : Controller {
    
    static let SPEED : Double = 500
    
    override func setup(parent: SKNode) {
        addFlyAction(parent)
        setupPhysics()
    }
    
    func addFlyAction(parent: SKNode) {
        let timeToBot = Double(self.view.position.y) / EnemyBulletController.SPEED
        self.view.runAction(
            SKAction.sequence(
                [
                    SKAction.moveToY(0, duration: timeToBot),
                    SKAction.removeFromParent()
                ]
            )
        )
    }
    
    func setupPhysics() {
        self.view.physicsBody = SKPhysicsBody(rectangleOfSize: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_ENEMY_BULLET
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER
    }
    
    
}
