//
//  View.swift
//  Session1
//
//  Created by Apple on 9/22/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

typealias HandleContactType = ((otherView: View) -> Void)

class View : SKSpriteNode {
    var handleContact : HandleContactType?
}
