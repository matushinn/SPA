//
//  PhysicEarthNode.swift
//  AR_physicsBody
//
//  Created by 大江祥太郎 on 2018/12/27.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import ARKit

class PhysicEarthNode: SCNNode {
    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(){
        super.init()
        //ジオメトリを作る
        let earth = SCNSphere(radius: 0.05)
        //テクスチャ
        earth.firstMaterial?.diffuse.contents = UIImage(named: "earth_1024")
        // ノードのgeometryプロパティに設定する
        geometry = earth
        
        //物理ボディを設定する
        let bodyShape = SCNPhysicsShape(geometry: geometry!, options: [:])
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: bodyShape)
        //摩擦力
        physicsBody?.friction = 2.0
        //反発力
        physicsBody?.restitution = 0.2
        
        //衝突する相手を決める
        //自身のカテゴリ
        physicsBody?.categoryBitMask = Category.boxCategory
        //衝突相手
        physicsBody?.collisionBitMask = Category.all
    }

}
