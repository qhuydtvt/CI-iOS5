//
//  EnemyPlaneController.swift
//  Session1
//
//  Created by Apple on 9/22/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class EnemyPlaneControler: Controller {
    
    let SPEED : Double = 100
    
    override func setup(parent: SKNode) {
        addFlyAction(parent)
        configurePhysics()
    }
    
    func configurePhysics() -> Void {
        // 1
        view.physicsBody = SKPhysicsBody(rectangleOfSize: view.frame.size)
        
        // 2
        view.physicsBody?.categoryBitMask = PHYSICS_MASK_ENEMY
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER_BULLET
    }
    
    // TODO
    func addFlyAction(parent: SKNode) -> Void {
        // 1
        let distanceToBottom = Double(self.view.position.y)
        // 2
        let timeToReachBottom = distanceToBottom / SPEED
        
        // 3
        self.view.runAction(
            SKAction.sequence([
                SKAction.moveToY(0, duration: timeToReachBottom),
                SKAction.removeFromParent()
                ])
        )
    }
}
