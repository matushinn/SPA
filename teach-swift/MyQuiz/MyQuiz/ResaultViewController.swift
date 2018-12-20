//
//  ResaultViewController.swift
//  MyQuiz
//
//  Created by 大江祥太郎 on 2018/12/18.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class ResaultViewController: UIViewController {

    @IBOutlet weak var correctPercentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        //問題数を取得する
        let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        
        //正解数を取得する
        var correctCount:Int = 0
        
        //正解数を計算する
        for questionData in QuestionDataManager.sharedInstance.questionDataArray{
            if questionData.isCorrect(){
                //正解数を増やす
                correctCount += 1
            }
        }
        
        //正解率を計算する
        let correctPercent:Float = Float(correctCount)/Float(questionCount) * 100
        
        //正解率を少数第一位まで計算して画面に反映する
        correctPercentLabel.text = String(format: "%.1f", correctPercent) + "%"
    }
    

    

}
