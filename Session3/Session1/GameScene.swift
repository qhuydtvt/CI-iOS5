//
//  GameScene.swift
//  Session1
//
//  Created by Apple on 8/28/16.
//  Copyright (c) 2016 TechKids. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // Nodes
    var plane:SKSpriteNode!
    var bullets : [SKSpriteNode] = []
    var enemies : [SKSpriteNode] = []
    
    //
    var lastUpdateTime : NSTimeInterval = -1
    
    // Counters
    var bulletIntervalCount = 0
    var enemyIntervalCount = 0
    
    override func didMoveToView(view: SKView) {
        addBackground()
        addPlane()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesBegan")
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesMoved")
        print("touches count: \(touches.count)")
        if let touch = touches.first {
            // 1
            let currentTouchPosition = touch.locationInNode(self)
            let previousTouchPosition = touch.previousLocationInNode(self)
            
            // 2 Calculate movement vector and then move the plane by this vector
            plane.position = currentTouchPosition.subtract(previousTouchPosition).add(plane.position)
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        print("\(currentTime)")
        
        if lastUpdateTime == -1 {
            lastUpdateTime = currentTime
        } else {
            let deltaTime = currentTime - lastUpdateTime
            let deltaTimeInMiliseconds = deltaTime * 1000
            if deltaTimeInMiliseconds > 10 {
//                bulletIntervalCount += 1
//                if bulletIntervalCount > 10 {
//                    bulletIntervalCount = 0
//                    addBullet()
//                }
                
                self.enemyIntervalCount += 1
                if self.enemyIntervalCount > 100 {
                    self.enemyIntervalCount = 0
                    addEnemy()
                }
                
                lastUpdateTime = currentTime
            }
        }
        
        for (bulletIndex, bullet) in bullets.enumerate() {
            for (enemyIndex, enemy) in enemies.enumerate() {
                // 1
                let bulletFrame = bullet.frame
                let enemyFrame = enemy.frame
                
                // 2
                if CGRectIntersectsRect(bulletFrame, enemyFrame) {
                    // 3
                    bullet.removeFromParent()
                    enemy.removeFromParent()
                    
                    // 4
                    bullets.removeAtIndex(bulletIndex)
                    enemies.removeAtIndex(enemyIndex)
                }
            }
        }
        
//        for bullet in bullets {
//            bullet.position.y += 30
//        }
        
        for enemy in enemies {
            enemy.position.y -= 10
        }
    }
    
    
    func addEnemy() {
        // 1
        let enemy = SKSpriteNode(imageNamed: "plane1.png")
        
        // 2
        enemy.position = CGPoint(x: self.frame.width / 2, y: self.frame.height - 50)
        
        // 3
        addChild(enemy)
        
        //4
        enemies.append(enemy)
    }
    
    func addBullet() {
        // 1
        let bullet = SKSpriteNode(imageNamed: "bullet.png")
        
        // 2
        bullet.position = plane.position
        
        // 3
        self.addChild(bullet)
        
        // 4
        let bulletFly = SKAction.moveByX(0, y: 30, duration: 0.1)
        
        // 5
        bullet.runAction(SKAction.repeatActionForever(bulletFly))
        
        // 5
        bullets.append(bullet)
    }
    
    func addBackground() {
        // 1
        let background = SKSpriteNode(imageNamed: "background.png")
        
        // 2
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        
        // 3
        addChild(background)
    }
    
    func addPlane() {
        // 1
        plane = SKSpriteNode(imageNamed: "plane3.png")
        
        // 2
        plane.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        
        // 3
        let shot = SKAction.runBlock {
            self.addBullet()
        }
        let periodShot = SKAction.sequence([shot, SKAction.waitForDuration(0.1)])
        let shotForever = SKAction.repeatActionForever(periodShot)
        
        // 4
        plane.runAction(shotForever)
        
        // 5
        addChild(plane)
    }
}
