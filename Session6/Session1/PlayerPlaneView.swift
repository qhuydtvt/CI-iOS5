//
//  PlayerPlaneView.swift
//  Session1
//
//  Created by Apple on 9/25/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

typealias GetGiftType = ((giftCode: Int) -> Void)
typealias DoubleBulletType = (() -> Void)

class PlanePlayerView: View {
    var doubleBullet : DoubleBulletType?
}
