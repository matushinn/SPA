//
//  ViewController.swift
//  Kingaku
//
//  Created by 大江祥太郎 on 2018/12/16.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var priceField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        let value = priceField.text! + "00"
        if let price = Int(value){
            priceField.text = "\(price)"
        }
        
    }
    @IBAction func tapClearButton(_ sender: Any) {
        priceField.text = "0"
    }
    
    func calcProcess(index:Int){
        let value = priceField.text! + "\(index)"
        if let price = Int(value){
            priceField.text = "\(price)"
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面に取り出す
        let viewController = segue.destination as! PercentViewController
        
        //金額フィールドの文字列を数値に変換する
        if let price = Int(priceField.text!){
            //数値に変換した金額を次の画面に設定する
            viewController.price = price
        }
    }
    

}

