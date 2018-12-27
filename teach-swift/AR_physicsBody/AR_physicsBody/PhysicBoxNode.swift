//
//  PhysicBoxNode.swift
//  AR_physicsBody
//
//  Created by 大江祥太郎 on 2018/12/27.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import ARKit

class PhysicBoxNode: SCNNode {
    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(){
        super.init()
        //ジオメトリを作る
        let box = SCNBox(width: 0.1, height: 0.05, length: 0.1, chamferRadius: 0.01)
        //塗り
        box.firstMaterial?.diffuse.contents = UIColor.gray
        //ノードのgeometryプロパティに設定する
        geometry = box
        
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
