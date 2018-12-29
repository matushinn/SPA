//
//  ViewController.swift
//  BezierPath_line
//
//  Created by 大江祥太郎 on 2018/12/29.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func drawLine() -> UIImage {
        //折れ線にする点の配列
        var pointList = Array<CGPoint>()
        //点の個数
        let pointCount = 20
        //xの間隔
        let dx = Int(view.frame.width)/pointCount
        //yの振幅
        let height = UInt32(view.frame.height)/2
        //点の配列を作る
        for n in 1...pointCount{
            let px = CGFloat(dx*n)
            let py = CGFloat(arc4random_uniform(height) + 50)
            let point = CGPoint(x: px, y: py)
            pointList.append(point)
        }
        
        //イメージ処理の開始
        let size = view.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        //パスの初期化
        let drawPath = UIBezierPath()
        //始点に移動する
        drawPath.move(to: pointList[0])
        //配列から始点の値を取り除く
        pointList.removeFirst()
        //配列から点を取り出して連結していく
        for pt in pointList{
            drawPath.addLine(to: pt)
        }
        
        //緑の色
        UIColor.blue.setStroke()
        //縦幅
        drawPath.lineWidth = 2.0
        //線のつなぎ目の形状
        drawPath.lineJoinStyle = .round
        //点線にする
        drawPath.setLineDash([4.0,2.0], count: 2, phase: 0.0)
        //線を描く
        drawPath.stroke()
        
        //イメージコンテキストからUIImageを作る
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //イメージ処理の終了
        UIGraphicsEndImageContext()
        
        return image!
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //図形のイメージを作る
        let drawImage = drawLine()
        //イメージビューに設定する
        let drawView = UIImageView(image: drawImage)
        //画面に表示する
        view.addSubview(drawView)
        
    
    }


}

