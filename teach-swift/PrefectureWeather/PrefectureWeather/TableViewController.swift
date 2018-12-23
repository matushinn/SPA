//
//  TableViewController.swift
//  PrefectureWeather
//
//  Created by 大江祥太郎 on 2018/12/16.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Alamofireを利用して通信を行います。
        Alamofire.request("https://query.yahooapis.com/v1/public/yql?q=select*%20from%20xml%20where%20url%20%3D%20%27http%3A%2F%2Fweather.livedoor.com%2Fforecast%2Frss%2Fprimary_area.xml%27&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").responseJSON { (response: DataResponse<Any>) in
            
            print(response)
        }
        if response.result.isFailure == true {
            self.simpleAlert(title: "通信エラー", message: "通信に失敗しました")
            return
        }
    }
    func simpleAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
        
        present(alert,animated: true,completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
