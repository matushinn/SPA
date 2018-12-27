//
//  PlaneNode.swift
//  AR_physicsBody
//
//  Created by 大江祥太郎 on 2018/12/27.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PlaneNode: SCNNode {
    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(anchor:ARPlaneAnchor){
        super.init()
        //平面のジオメトリを作る
        let planeHight:Float = 0.01
        let plane = SCNBox(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.x),length:CGFloat(anchor.extent.z),chamferRadius:0.0)
        //緑で塗りは半透明（ワイヤーフレームはsceneViewで設定、白色）
        plane.firstMaterial?.diffuse.contents = UIColor.green.withAlphaComponent(0.5)
        plane.widthSegmentCount = 10
        plane.heightSegmentCount = 1
        plane.lengthSegmentCount = 10
        //ノードのgeometryプロパティに設定する
        geometry = plane
        
        //位置決めする
        position = SCNVector3(anchor.center.x,-planeHight,anchor.center.z)
        
        //物理ボディを作る
        let bodyShape = SCNPhysicsShape(geometry: geometry!, options: [:])
        physicsBody = SCNPhysicsBody(type:.static,shape:bodyShape)
        //摩擦
        physicsBody?.friction = 3.0
        //反発力
        physicsBody?.restitution = 0.2
        
        //衝突する相手を決める
        //自身のカテゴリ
        physicsBody?.categoryBitMask = Category.planeCategory
        //衝突の相手
        physicsBody?.collisionBitMask = Category.all ^ Category.planeCategory
        
        
    }
    //位置とサイズを更新する
    func update(anchor: ARPlaneAnchor){
        //ダウンキャストする
        let plane = geometry as! SCNBox
        //アンカーから平面の幅、高さを更新する
        plane.width = CGFloat(anchor.extent.x)
        plane.height = CGFloat(anchor.extent.z)
        
        //物理ボディの形を更新する
        let bodyShape = SCNPhysicsShape(geometry: geometry!, options: [:])
        physicsBody?.physicsShape = bodyShape
        
        //座標を更新する
        position = SCNVector3(anchor.center.x,0,anchor.center.z)
        
    }
}
