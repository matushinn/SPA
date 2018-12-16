//
//  ResultViewController.swift
//  Kingaku
//
//  Created by 大江祥太郎 on 2018/12/16.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    let price:Int = 0
    
    let percent:Int = 0
    
    @IBOutlet weak var resultTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
    //割引りつを算出する
    let percentValue = Float(percent)/100
    
    //割引額を算出する
    let waribikiPrice = Float(price) * percentValue
    
    //割引後の価格を算出する
    let percentOfPrice = price - Int(waribikiPrice)
    
    //結果表示
    resultTextField.text = "\(percentOfPrice)"
        
    }

    @IBAction func restart(_ sender: Any) {
        resultTextField.text = "0"
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    

}
