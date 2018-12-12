//
//  addListViewController.swift
//  MemoApp
//
//  Created by 大江祥太郎 on 2018/12/13.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class addListViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextField!
    
    var array=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: Any) {
        array.append(textView.text!)
        
        UserDefaults.standard.set(array, forKey: "hoge")
        
        self.navigationController?.popViewController(animated: true)
    }
    

    
}
