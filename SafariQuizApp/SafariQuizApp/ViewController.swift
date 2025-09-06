//
//  ViewController.swift
//  SafariQuizApp
//
//  Created by Mehraab Singh on 06/09/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    let questions: [QuestionModel] = [
        QuestionModel(image: UIImage(named: "lion")!, correctAnswer: 2, answer1: "Hippo", answer2: "Lion", answer3: "Antelope"),
        QuestionModel(image: UIImage(named: "giraffe")!, correctAnswer: 1, answer1: "Giraffe", answer2: "Crocodile", answer3: "Elephant"),
        QuestionModel(image: UIImage(named: "Buffalo")!, correctAnswer: 3, answer1: "Antelope", answer2: "Lion", answer3: "Buffalo")
    ]
    var score = 0
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestion()
        // Do any additional setup after loading the view.
    }
    func nextQuestion(){
        currentQuestionIndex += 1
        guard currentQuestionIndex <= questions.count - 1 else{
            print("We have reached at the end of the quizz")
            currentQuestionIndex = 0
            score = 0
            scoreLabel.text = "Score: 0"
            setupQuestion()
            return
        }
        setupQuestion()
    }
    func setupQuestion(){
        let currentQuestion = questions[currentQuestionIndex]
        questionImageView.image = currentQuestion.image
        answer1Button.setTitle(currentQuestion.answer1, for: .normal)
        answer2Button.setTitle(currentQuestion.answer2, for: .normal)
        answer3Button.setTitle(currentQuestion.answer3, for: .normal)
    }
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.nextQuestion()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    func showFinalScoreAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.nextQuestion()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    func check(selectedAnswer answer: Int){
        let currentQuestion = questions[currentQuestionIndex]
        var alertTitle = ""
        var alertMeassage = ""
        
        if currentQuestion.correctAnswer == answer {
            print("Answer is correct!")
            score += 1
            scoreLabel.text = "Score: \(score)"
            if currentQuestionIndex == questions.count - 1 {
                alertTitle = "End of Quiz"
                alertMeassage = "Your final score is \(score) / \(questions.count)"
            }else{
                alertTitle = "Correct!"
                alertMeassage = "Keep Going!"
            }
        } else {
            print("Answer incorrect")
            if currentQuestionIndex == questions.count - 1 {
                alertTitle = "End of Quiz"
                alertMeassage = "Your final score is \(score) / \(questions.count)"
            }else{
                alertTitle = "Incorrect!"
                alertMeassage = "Try again next time!"
            }
        }
        
        showAlert(title: alertTitle, message: alertMeassage)
    }
    @IBAction func answer1ButtonTapped(_ sender: Any) {
        check(selectedAnswer: 1)
    }
    @IBAction func answer2ButtonTapped(_ sender: Any) {
        check(selectedAnswer: 2)
    }
    @IBAction func answer3ButtonTapped(_ sender: Any) {
        check(selectedAnswer: 3)
    }
}

