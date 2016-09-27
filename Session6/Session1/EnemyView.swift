//
//  EnemyView.swift
//  Session1
//
//  Created by Apple on 9/25/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

typealias GetHitType = ((damage: Int) -> Void)

class EnemyView: View {
    var getHit : GetHitType?
}
