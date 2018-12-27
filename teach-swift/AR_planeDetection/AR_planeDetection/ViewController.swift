//
//  ViewController.swift
//  AR_planeDetection
//
//  Created by 大江祥太郎 on 2018/12/27.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        //ノードのワイヤーフレームを表示
        sceneView.debugOptions = .showWireframe
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        //平面の検出を有効化する
        configuration.planeDetection = [.horizontal,.vertical]
        
        // セッション開始
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // セッションやめる
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
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
