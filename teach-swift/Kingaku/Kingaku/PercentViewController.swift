//
//  PercentViewController.swift
//  Kingaku
//
//  Created by 大江祥太郎 on 2018/12/16.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class PercentViewController: UIViewController {
    
    //金額を受け取るプロパティ
    var price:Int = 0
    
    //割引パーセント入力フィールド
    
    @IBOutlet weak var percentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tap1Button(_ sender: Any) {
        calcProcess(index: 1)
    }
    @IBAction func tap2Button(_ sender: Any) {
        calcProcess(index: 2)
    }
    @IBAction func tap3Button(_ sender: Any) {
        calcProcess(index: 3)
    }
    @IBAction func tap4Button(_ sender: Any) {
        calcProcess(index: 4)
    }
    
    @IBAction func tap5Button(_ sender: Any) {
        calcProcess(index: 5)
    }
    @IBAction func tap6Button(_ sender: Any) {
        calcProcess(index: 6)
    }
    @IBAction func tap7Button(_ sender: Any) {
        calcProcess(index: 7)
    }
    @IBAction func tap8Button(_ sender: Any) {
        calcProcess(index: 8)
    }
    @IBAction func tap9Button(_ sender: Any) {
        calcProcess(index: 9)
    }
    @IBAction func tap0Button(_ sender: Any) {
        calcProcess(index: 0)
    }
    @IBAction func tap00Button(_ sender: Any) {
        let value = percentField.text! + "00"
        if let percent = Int(value){
            percentField.text = "\(percent)"
        }
        
    }
    @IBAction func tapClearButton(_ sender: Any) {
        percentField.text = "0"
    }
    
    func calcProcess(index:Int){
        let value = percentField.text! + "\(index)"
        if var percent = Int(value){
            percentField.text = "\(percent)"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面取り出す
        let viewController = segue.destination as! ResultViewController
        
        //次の画面に今保持している金額を設定する
        viewController.price = price
        
        if let percent = Int(percentField.text!){
            //次の画面に現在保持しているパーセンテージを設定する
            viewController.percent = percent
        }
        
        
    }
    

}
