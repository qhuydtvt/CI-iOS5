//
//  GameScene.swift
//  Session1
//
//  Created by Apple on 8/28/16.
//  Copyright (c) 2016 TechKids. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Nodes
    //var plane:SKSpriteNode!
    
    //
    var lastUpdateTime : NSTimeInterval = -1
    
    // Counters
    var bulletIntervalCount = 0
    var enemyIntervalCount = 0
    
    // Controllers
    var playerPlaneController : PlayerPlaneController!
    
    override func didMoveToView(view: SKView) {
        addBackground()
        addPlane()
        addEnemy()
        configurePhysics()
        
        self.runAction(SKAction.repeatForeverWithDuration(5, block: self.addPowerup))
    }
    
    func addPowerup() -> Void {
        let powerUp = View(imageNamed: "power-up.png")
        
        powerUp.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
        
        let powerUpController = PowerupController(view: powerUp)
        
        powerUpController.setup(self)
        
        self.addChild(powerUpController.view)
    }
    
    func configurePhysics() -> Void {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        let viewA = bodyA.node as! View
        let viewB = bodyB.node as! View
        
        if let aHandleContact = viewA.handleContact {
            aHandleContact(otherView: viewB)
        }
        
        if let bHandleContact = viewB.handleContact {
            bHandleContact(otherView: viewA)
        }
       
        
//        if let nodeA = bodyA.node {
//            if let nodeB = bodyB.node {
//                if (((nodeA.physicsBody?.categoryBitMask)! | (nodeB.physicsBody?.categoryBitMask)!) == (PHYSICS_MASK_PLAYER | PHYSICS_MASK_ENEMY_BULLET) ) {
//                    nodeA.removeFromParent()
//                    nodeB.removeFromParent()
//                }
//            }
//        }
        
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
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
            
            playerPlaneController.moveBy(
                currentTouchPosition.subtract(previousTouchPosition)
            )
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
            let enemy = EnemyView()
            enemy.size = CGSize(width: 40, height: 40)
            
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
            enemy.runAction(SKAction.repeatActionForever(animate))
            
            let enemyController = EnemyPlaneControler(view: enemy)
            
            enemyController.setup(self)
            
            // 5
            self.addChild(enemy)
            
            // 6
            enemy.name = "enemy"
        }
        
        let enemySpawnPeriod = SKAction.sequence([enemySpawn, SKAction.waitForDuration(1.0)])
        
        let enemySpawnPeriodForever = SKAction.repeatActionForever(enemySpawnPeriod)
        
        self.runAction(enemySpawnPeriodForever)
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
        let planeView = PlanePlayerView(imageNamed: "plane3.png")
        
        // 2
        planeView.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        
        // 3
        self.playerPlaneController = PlayerPlaneController(view: planeView)
        
        // 3
        self.playerPlaneController.setup(self)
        
        // 4
        addChild(planeView)
    }
    
    func addSimpleNode() {
        let simpleNode = SKLabelNode(text: "O")
        simpleNode.name = "simple"
        simpleNode.position = CGPoint(x: 10, y: 10)
        addChild(simpleNode)
    }
}
