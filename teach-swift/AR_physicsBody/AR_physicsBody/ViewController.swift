//
//  ViewController.swift
//  AR_physicsBody
//
//  Created by 大江祥太郎 on 2018/12/27.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var nodes:Array<SCNNode>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        
        
        // Create a new scene
        let scene = SCNScene()
        
        //ワイヤーフレーム表示
        sceneView.debugOptions = [.showWireframe,.showPhysicsShapes]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        //平面の検出を有効化する,（平面、垂直面）
        configuration.planeDetection = [.horizontal,.vertical]
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    @IBAction func tapSceneView(_ sender: UITapGestureRecognizer) {
        //検知平面とのヒットテスト
        //タップした2D座標
        let tapLoc = sender.location(in:sceneView)
        //検知平面とタップ座標のヒットテスト
        let results = sceneView.hitTest(tapLoc, types: .existingPlaneUsingExtent)
        //検知表面をタップしていたら最前面のヒットデータをresultに入れる
        guard let result = results.first else {
            return
        }
        //検出したアンカーを取得する
        if let anchor = result.anchor as? ARPlaneAnchor{
            //水平面でない場合は処理をキャンセルする
            if anchor.alignment == .vertical{
                return
            }
        }
        
       
        //二種類の物理ボディのノードを作る
        let boxNode = PhysicBoxNode()
        let earthNode = PhysicEarthNode()
        nodes = [boxNode,earthNode]
        
        //追加するノードをランダムに選ぶ
        let index = Int(arc4random()) % (nodes.count)
        let node = nodes[index]
        
        //ヒットテストの結果からAR空間のワールド座標を取り出す
        let pos = result.worldTransform.columns.3
        //0.2m上から落とす
        let y = pos.y + 0.2
        node.position = SCNVector3(pos.x,y,pos.z)
        
        //シーンに箱ノードを追加する
        //物理ボディのノードを上から落とす
        sceneView.scene.rootNode.addChildNode(node)
        
    }
    //ノードが追加された
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        //平面アンカーでないときは中断する
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        //アンカーが示す位置に平面ノードを追加する
        node.addChildNode(PlaneNode(anchor:planeAnchor))
    }
    //ノードが更新された
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        //平面アンカーではないときは中断する
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        //planenodeでないときは中断する
        guard let planeNode = node.childNodes.first as? PlaneNode else {
            return
        }
        
        //ノードの位置とサイズを更新する
        planeNode.update(anchor:planeAnchor)
    }
    
    //セッションをリスタートする
    @IBAction func restart(_ sender: Any) {
        //追加したノードを全て取り除く
        for node in sceneView.scene.rootNode.childNodes{
            node.removeFromParentNode()
        }
        //現在のコンフィグ
        let configuration = sceneView.session.configuration
        //リセット後にセッションを開始する
        let runOptions:ARSession.RunOptions = [.resetTracking,.removeExistingAnchors]
        sceneView.session.run(configuration!, options: runOptions)
    }
    
    /*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
