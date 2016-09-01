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
        let background = SKSpriteNode(imageNamed: "background.png")
        
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        
        plane = SKSpriteNode(imageNamed: "plane3.png")
        plane.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        
        addChild(background)
        addChild(plane)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let touchPosition = touch.locationInView(self.view)
            plane.position = CGPoint(x: touchPosition.x, y: self.frame.size.height-touchPosition.y)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
