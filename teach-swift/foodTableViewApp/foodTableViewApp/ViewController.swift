//
//  ViewController.swift
//  foodTableViewApp
//
//  Created by 大江祥太郎 on 2018/12/13.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource{
    
    //型推論
    var foods = ["カレー","ハンバーグ","プリン"]
    //食べ物の画像の配列
    var foodImages = [UIImage(named: "curry.jpg"),
                      UIImage(named: "hanbag.jpg"),
                      UIImage(named: "purinn.jpg")]

    @IBOutlet weak var foodTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //データソースメソッドをこのファイル内で処理しますよ
        foodTableView.dataSource = self
        //不要なCellの消去
        foodTableView.tableFooterView = UIView()
    
    }
    //TableViewに表示するデータの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    //TableViewに表示するデータの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //再利用可能なセル
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        /*
        //セルに標準搭載されているtextLabel
        //indexpath.rowは今扱っているcellの番号のこと
        cell.textLabel?.text = foods[indexPath.row]
        cell.imageView?.image = foodImages[indexPath.row]
        */
        
        //表示内容を決める
        let foodImageView = cell.viewWithTag(1)as!UIImageView
        let foodNumLabel = cell.viewWithTag(2) as! UILabel
        
        foodImageView.image = foodImages[indexPath.row]
        foodNumLabel.text = foods[indexPath.row]
        
        return cell
    }
    
    


}

