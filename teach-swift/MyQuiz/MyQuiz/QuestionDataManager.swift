//
//  QuestionDataManager.swift
//  MyQuiz
//
//  Created by 大江祥太郎 on 2018/12/18.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import Foundation

//一つの問題に対する情報を格納するデータクラス
class QuestionData{
    
    //問題文
    var question:String!
    
    //選択肢１
    var answer1:String!
    
    //選択肢2
    var answer2:String!
    
    //選択肢3
    var answer3:String!
    
    //選択肢4
    var answer4:String!
    
    //正解の番号
    var correctAnswerNumber:Int!
    
    //ユーザーが選択した選択肢の番号
    var userChoiceAnswerNumber:Int?
    
    //問題の番号
    var questionNo:Int = 0
    
    init(questionSourceDataArray:[String]) {
        question = questionSourceDataArray[0]
        answer1 = questionSourceDataArray[1]
        answer2 = questionSourceDataArray[2]
        answer3 = questionSourceDataArray[3]
        answer4 = questionSourceDataArray[4]
        
        correctAnswerNumber = Int(questionSourceDataArray[5])!
    }
    
    //ユーザーが選択した答えが正解かどうか判定する
    func isCorrect() -> Bool{
        //答えが一致しているかどうか判定する
        if correctAnswerNumber == userChoiceAnswerNumber{
            //正解
            return true
        }else{
            //不正解
            return false
        }
        
    }
    
    
}
 //クイズデータ全般の管理と成績を管理するクラス
class QuestionDataManager{
    
    //シングルトンのオブジェクトを生成
    static let sharedInstance = QuestionDataManager()
    
    //問題を格納するための配列
    var questionDataArray = [QuestionData]()
    
    //現在の問題のインデックス
    var nowQuestionIndex:Int = 0
    
    //初期化処理
    private init(){
        //シングルトンであることを保障するためにprivateで宣言しておく
    }
    
    //問題文の読み込み処理
    func loadQuestion(){
        //格納ずみの問題文があれば一旦消去しておく
        questionDataArray.removeAll()
        
        //現在の問題のインデックスを初期化
        nowQuestionIndex = 0
        
        //csvファイルパスを取得
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv")else{
            //csvファイルなし
            print("csvファイルが存在しません")
            return
        }
        
        //csvファイル読み込み
        do{
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            //csvデータを一行ずつ読みこむ
            csvStringData.enumerateLines (invoking: { (line, stop) in
                //カンマ区切りで分割
                let questionSourceDataArray = line.components(separatedBy: ",")
                
                //問題データを格納するオブジェクトを作成
                let questionData = QuestionData(questionSourceDataArray:questionSourceDataArray)
                
                //問題を追加
                self.questionDataArray.append(questionData)
                
                //問題番号を設定
                questionData.questionNo = self.questionDataArray.count
            })
        } catch let error{
            print("csvファイルに読み込みエラーが発生しました。:\(error)")
            return
        }
    }
    //次の問題を取り出す
    func nextQuestion() -> QuestionData? {
        if nowQuestionIndex < questionDataArray.count{
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
    
}
