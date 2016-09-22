//
//  Controller.swift
//  Session1
//
//  Created by Apple on 9/22/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class Controller {
    internal let view: View
    
    init(view: View) {
        self.view = view
    }
    
    func setup(parent: SKNode) -> Void {
    }
    
    // Move to a specific position
    func moveTo(position: CGPoint) -> Void {
        self.view.position = position
    }
    
    // Move by a vector
    func moveBy(vector: CGPoint) -> Void {
        let newPosition = self.view.position.add(vector)
        self.view.position = newPosition
    }
}
