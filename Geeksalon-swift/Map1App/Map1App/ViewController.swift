//
//  ViewController.swift
//  Map1App
//
//  Created by 大江祥太郎 on 2018/12/15.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var userDefName = "pins"
    override func viewDidLoad() {
        super.viewDidLoad()
        //保存されているピンを配置
        loadPins()
    }

    @IBAction func longTapMapView(_ sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began{
            //ロングタップ以外では認識しない
            return
        }
        print("longtapしました。")
        
        //位置情報の取得
        let point = sender.location(in: mapView)
        let geo = mapView.convert(point, toCoordinateFrom: mapView)
        //アラートの作成
        let alert = UIAlertController(title: "スポット登録", message: "この場所に残すメッセージを入力してください。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "登録", style: .default, handler: { (action: UIAlertAction) -> Void in
            // 登録アクション
            let pin = Pin(geo: geo, text: alert.textFields?.first?.text)
            
            self.mapView.addAnnotation(pin)
            
            self.savePin(pin)
        }))
        
        //ピンに登録するテキスト用の入力フィールドをアラートに追加します
        alert.addTextField { (textFiled:UITextField) in
            textFiled.placeholder = "メッセージ"
        }
        
        //アラートの表示
        present(alert, animated: true, completion: nil)
    }
    
    //pinの保存
    func savePin(_ pin:Pin){
        let ud = UserDefaults.standard
        
        //保存するPinをUserdefaults用に変換します
        let pinInfo = pin.toDictionary()
        
        if var savedPins = ud.object(forKey: userDefName)as? [[String:Any]]{
            //すでにPinデータがある場合、それに追加する形で保存します
            savedPins.append(pinInfo)
            ud.set(savedPins, forKey: userDefName)
        }else{
            //まだ保存データがない場合、新しい配列に保存する
            let newSavedPins :[[String:Any]] = [pinInfo]
            
            ud.set(newSavedPins, forKey: userDefName)
        }
    }
    
    //すでに保存されているピンを取得
    func loadPins(){
        let ud = UserDefaults.standard
        if let savedPins = ud.object(forKey: userDefName) as? [[String:Any]]{
            //現在のピンを消去
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            for pinInfo in savedPins{
                let newPin = Pin(dictionary: pinInfo)
                
                self.mapView.addAnnotation(newPin)
            }
        }
    }
    
}

