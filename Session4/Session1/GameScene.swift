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
    
    //
    var lastUpdateTime : NSTimeInterval = -1
    
    // Counters
    var bulletIntervalCount = 0
    var enemyIntervalCount = 0
    
    override func didMoveToView(view: SKView) {
        addBackground()
        addPlane()
        addEnemy()
        addSimpleNode()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesBegan")
        // 1
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            
            let touchedNodes =
                self.nodesAtPoint(location)
            for node in touchedNodes {
                if node.name == "simple" {
                    print("Simple node has been touched")
                }
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesMoved")
        print("touches count: \(touches.count)")
        if let touch = touches.first {
            // 1
            let currentTouchPosition = touch.locationInNode(self)
            let previousTouchPosition = touch.previousLocationInNode(self)
            
            // 2 Calculate movement vector and then move the plane by this vector
            let move = SKAction.moveTo(currentTouchPosition
                .subtract(previousTouchPosition)
                .add(plane.position), duration: 0)
            plane.runAction(move)
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        print("\(currentTime)")
        
        self.enumerateChildNodesWithName("enemy") {
            enemyNode, _ in
            self.enumerateChildNodesWithName("bullet") {
                bulletNode, _ in
                let bulletFrame = bulletNode.frame
                let enemyFrame = enemyNode.frame
                
                // 2
                if CGRectIntersectsRect(bulletFrame, enemyFrame) {
                    // 3
                    bulletNode.removeFromParent()
                    enemyNode.removeFromParent()
                    self.runAction(SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false))
                }
            }
        }
    }
    
    func addEnemy() {
        
        let enemySpawn = SKAction.runBlock {
            
            // 1
            let enemy = SKSpriteNode(imageNamed: "plane1.png")
            
            // 2
            enemy.position = CGPoint(x: self.frame.width / 2, y: self.frame.height - 50)
            
            // 3
            var textures : [SKTexture] = []
            let nameFormat = "enemy_plane_white_"
            for i in 1..<4 {
                let imageName = "\(nameFormat)\(i).png"
                let texture = SKTexture(imageNamed: imageName)
                textures.append(texture)
            }
            
            let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.02)
            
            // 4
            let enemyFly = SKAction.moveByX(0, y: -20, duration: 0.2)
            
            enemy.runAction(SKAction
                .repeatActionForever(enemyFly))
            enemy.runAction(SKAction.repeatActionForever(animate))
            // 5
            self.addChild(enemy)
            
            // 6
            enemy.name = "enemy"
        }
        
        let enemySpawnPeriod = SKAction.sequence([enemySpawn, SKAction.waitForDuration(1.0)])
        
        let enemySpawnPeriodForever = SKAction.repeatActionForever(enemySpawnPeriod)
        
        self.runAction(enemySpawnPeriodForever)
    }
    
    func addBullet() {
        // 1
        let bullet = SKSpriteNode(imageNamed: "bullet.png")
        
        // 2
        bullet.position = plane.position.add(
            CGPoint(x: 0, y: plane.frame.height / 2 +
                bullet.frame.height / 2 + 10)
            )
        
        // 3
        self.addChild(bullet)
        
        // 4
        let bulletFly = SKAction.moveByX(0, y: 30, duration: 0.1)
        
        // 5
        bullet.runAction(SKAction.repeatActionForever(bulletFly))
        
        // 5
        bullet.name = "bullet"
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
        let playSound = SKAction.playSoundFileNamed("laser_shot.wav", waitForCompletion: false)
        let shot = SKAction.runBlock {
            self.addBullet()
        }
        
        let periodShot = SKAction.sequence([shot,
            playSound, SKAction.waitForDuration(0.1)])
        let shotForever = SKAction.repeatActionForever(periodShot)
        
        // 4
        plane.runAction(shotForever)
        
        // 5
        addChild(plane)
    }
    
    func addSimpleNode() {
        let simpleNode = SKLabelNode(text: "O")
        simpleNode.name = "simple"
        simpleNode.position = CGPoint(x: 10, y: 10)
        addChild(simpleNode)
    }
}
