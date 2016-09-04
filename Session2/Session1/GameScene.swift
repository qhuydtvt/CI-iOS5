//
//  GameScene.swift
//  Session1
//
//  Created by Apple on 8/28/16.
//  Copyright (c) 2016 TechKids. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var plane:SKSpriteNode!
    
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
    
    override func update(currentTime: CFTimeInterval) {
        
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
        addChild(plane)
    }
}
