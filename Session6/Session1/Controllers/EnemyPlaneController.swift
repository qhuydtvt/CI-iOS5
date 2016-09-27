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
    let SHOT_DURATION : Double = 0.5
    
    var hp : Int = 2
    
    override func setup(parent: SKNode) {
        addFlyAction(parent)
        addShotAction(parent)
        configurePhysics()
        setupResponds()
    }
    
    func setupResponds() {
        if let enemyView = self.view as? EnemyView {
            enemyView.getHit = {
                damage in
                self.hp -= damage
                if (self.hp <= 0) {
                    enemyView.removeFromParent()
                }
            }
        }
    }
    
    func configurePhysics() -> Void {
        // 1
        view.physicsBody = SKPhysicsBody(rectangleOfSize: view.frame.size)
        
        // 2
        view.physicsBody?.categoryBitMask = PHYSICS_MASK_ENEMY
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask =
        PHYSICS_MASK_PLAYER |
        PHYSICS_MASK_PLAYER_BULLET
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
    
    func addShotAction(parent: SKNode) -> Void {
        self.view.runAction(
            SKAction.repeatActionForever(
                SKAction.sequence(
                [
                    SKAction.runBlock{ self.createBullet(parent)},
                        SKAction.waitForDuration(SHOT_DURATION)
                ]
                )
            )
        )
    }
    
    private func createBullet(parent: SKNode) {
        // 1 Create View
        let enemyView = View(imageNamed: "enemy_bullet.png")
        
        enemyView.position = self.view.position
        
        // 2 Create Controller
        let enemyBulletController =
            EnemyBulletController(view: enemyView)
        
        // 3
        enemyBulletController.setup(parent)
        
        //4
        parent.addChild(enemyView)
    }
}
