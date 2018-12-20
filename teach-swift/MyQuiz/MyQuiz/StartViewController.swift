//
//  StartViewController.swift
//  MyQuiz
//
//  Created by 大江祥太郎 on 2018/12/18.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //次の画面に遷移する前に呼び出される準備処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //問題文の読み込み
        QuestionDataManager.sharedInstance.loadQuestion()
        
        //遷移先画面の呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else {
            //取得できずに終了
            return
        }
        
        //問題文の取り出し
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else {
            //取得できず終了
            return
        }
        
        //問題文のセット
        nextViewController.questionData = questionData
    }
    
    //タイトルに戻ってくる時の呼び出される処理

    @IBAction func goTitle(_ sender: Any) {
    }
    

}
