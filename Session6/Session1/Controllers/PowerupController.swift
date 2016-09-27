//
//  GiftController.swift
//  Session1
//
//  Created by Apple on 9/25/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class PowerupController : Controller {
    let SPEED : Double = 100
    
    override func setup(parent: SKNode) {
        addFlyAction(parent)
        
        self.view.physicsBody = SKPhysicsBody(rectangleOfSize: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_PLAYER
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER
        
        self.view.handleContact = {
            otherView in
            if let planePlayerView = otherView as? PlanePlayerView {
                if let doubleBullet = planePlayerView.doubleBullet {
                    doubleBullet()
                }
                self.view.removeFromParent()
            }
        }
    }
    
    func addFlyAction(parent: SKNode) -> Void {
        self.view.runAction(
            SKAction.sequence([
                SKAction.moveToBottom(self.view.position.y, speed: SPEED),
                SKAction.removeFromParent()
                ])
        )
    }
}
