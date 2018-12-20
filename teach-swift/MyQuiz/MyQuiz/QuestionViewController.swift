//
//  QuestionViewController.swift
//  MyQuiz
//
//  Created by 大江祥太郎 on 2018/12/18.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {
    
    var questionData:QuestionData!
    
    @IBOutlet weak var questionNoLabel: UILabel!
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var correctImageView: UIImageView!
    @IBOutlet weak var incorrectImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //初期データ設定処理。前画面で設定済みのquestionDataから値を取り出す
        
        questionNoLabel.text = "Q.\(questionData.questionNo)"
        
        questionTextView.text = questionData.question
        answer1Button.setTitle(questionData.answer1,for: .normal)
        answer2Button.setTitle(questionData.answer2,for: .normal)
        answer3Button.setTitle(questionData.answer3,for: .normal)
        answer4Button.setTitle(questionData.answer4,for: .normal)
    }
    
    @IBAction func tapAnswer1Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 1
        
    }
    @IBAction func tapAnswer2Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 2
    }
    @IBAction func tapAnswer3Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 3
    }
    @IBAction func tapAnswer4Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 4
    }
    
    //次の画面にアニメーション付きで進む
    func goNextQuestionWithAnimation(){
        //正解しているか判定する
        if questionData.isCorrect(){
            //正解アニメーションを再生しながら次の画面へ遷移する
            goNextQuestionWithCorrectAnimation()
        }else{
            //不正解のアニメーションを再生しながら次の問題へ遷移する
            goNextQuestionWithCorrectAnimation()
        }
    }
    
    //次の問題に正解のアニメーション付きで遷移する
    func goNextQuestionWithCorrectAnimation(){
        //正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(1025)
        
        //アニメーション
        UIView.animate(withDuration: 2.0,animations: {
            //alpha値を1.0に変化させる
            self.correctImageView.alpha = 1.0
            
        }){(Bool) in
            //アニメーション完了後に次の画面に進む
            self.goNextQuestion()
        }
    }
    
    //次の問題に不正解のアニメーション付きで遷移する
    func goNextQuestionWithIncorrectAnimation(){
        //不正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(1006)
        
        //アニメーション
        UIView.animate(withDuration: 2.0,animations: {
            //alpha値を1.0に変化させる
            self.incorrectImageView.alpha = 1.0
            
        }){(Bool) in
            //アニメーション完了後に次の画面に進む
            self.goNextQuestion()
        }
    }
    
    //次の問題へ遷移する
    func goNextQuestion(){
        //問題文の取り出し
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else {
            //問題がなければ結果画面に遷移する
            //StoryboardのIdentifierに設定した値（result）を指定して
            //ViewControllerを生成する
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier:"result") as? ResaultViewController{
                //storyboardのSegueを利用しない明示的な画面遷移処理
                present(resultViewController,animated: true,completion: nil)
            }
            return
        }
        
        //問題がある場合は次の問題へ遷移する
        //storyboardのIdentifierに設定した値（question）を設定して
        //ViewControllerを生成する
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController{
            nextQuestionViewController.questionData = nextQuestion
            //storyboardのSegueを利用しない明示的な画面遷移処理
            present(nextQuestionViewController,animated: true,completion: nil)
        }
    }
    
    
    
}
