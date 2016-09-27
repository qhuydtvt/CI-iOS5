//
//  PlayerPlaneController.swift
//  Session1
//
//  Created by Apple on 9/22/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class PlayerPlaneController : Controller {
    
    let SHOT_DURATION = 0.5
    var spawnBullet : ((parent: SKNode) -> Void)!
    
    override func setup(parent: SKNode) {
        addShotAction(parent)
        setupPhysics()
        setupResponds()
        
        self.spawnBullet = {
            parent in
            self.addBullet(parent, image: "bullet.png", damage: 1)
        }
    }
    
    func setupResponds() {
        if let playerPlaneView = self.view as? PlanePlayerView {
            playerPlaneView.doubleBullet = {
                self.view.runAction(
                    SKAction.sequence([
                        SKAction.runBlock {
                            self.spawnBullet = {
                                parent in
                                self.addBullet(parent, image: "bullet-double.png", damage: 2)
                            }
                        },
                        
                        SKAction.waitForDuration(1),
                        
                        SKAction.runBlock {
                            self.spawnBullet = {
                                parent in
                                self.addBullet(parent, image: "bullet.png", damage: 1)
                            }
                        },
                        
                        ])
                )
                
            }
        }
    }
    
    private func addShotAction(parent: SKNode) -> Void {
        self.view.runAction(
            SKAction.repeatActionForever(
                SKAction.sequence(
                    [
                        SKAction.runBlock { self.spawnBullet(parent: parent) },
                        SKAction.waitForDuration(SHOT_DURATION)
                    ]
                )
            )
        )
    }
    
    private func addBullet(parent: SKNode, image: String, damage: Int) {
        // 1
        let bulletView = View(imageNamed: image)
        
        // 2
        bulletView.position = view.position.add(
            CGPoint(x: 0, y: view.frame.height / 2 +
                bulletView.frame.height / 2 + 10)
        )
        
        // 3
        let bulletController = PlayerBulletController(view: bulletView)
        
        
        bulletController.damage = damage
        
        // 4
        bulletController.setup(parent) // ? ?
        
        // x
        parent.addChild(bulletView)
    }
    
    func setupPhysics() {
        self.view.physicsBody = SKPhysicsBody(rectangleOfSize: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_PLAYER
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_ENEMY | PHYSICS_MASK_ENEMY_BULLET
    }
}
