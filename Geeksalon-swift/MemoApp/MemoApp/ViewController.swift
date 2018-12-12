//
//  ViewController.swift
//  MemoApp
//
//  Created by 大江祥太郎 on 2018/12/13.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var resultArray=[String]()
    
    let ud = UserDefaults.standard
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = resultArray[indexPath.row]
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            resultArray.remove(at: indexPath.row)
            
            ud.set(resultArray, forKey: "array")
            
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ud.object(forKey: "hoge") != nil{
            resultArray = ud.object(forKey: "hoge") as! [String]
            
        }
        //データの更新
        tableView.reloadData()
        
    }
    
    


}

