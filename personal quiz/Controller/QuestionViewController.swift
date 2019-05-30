//
//  QuestionViewController.swift
//  personal quiz
//
//  Created by Sergiy Fugol on 5/24/17.
//  Copyright © 2019 Sergiy Fugol. All rights reserved.
//

import UIKit

/// Questions Screen
class QuestionViewController: UIViewController {

  // MARK: - IB Outlets
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var singleStackView: UIStackView!
  @IBOutlet var singleButtons: [UIButton]!

  @IBOutlet weak var multipleStackView: UIStackView!
  @IBOutlet var multipleLabels: [UILabel]!
  @IBOutlet var multipleSwitch: [UISwitch]!

  @IBOutlet weak var rangedStackView: UIStackView!
  @IBOutlet var rangedLabels: [UILabel]!
  @IBOutlet weak var rangedSlider: UISlider!

  @IBOutlet var nextButtons: [UIButton]!

  @IBOutlet weak var questionProgressView: UIProgressView!

  // MARK: - Stored Properties
  /// Answer choisen by user
  var answersChosen = [Answer]()

  /// Index of current question
  var questionIndex = 0
  /// Default font size from User Defaults
  var fontSize = 17
  //let fontSize: CGFloat = IntroductionViewController.font

  /// List of questions
  var question = Question.loadData()
}

// MARK: - IB Actions
extension QuestionViewController {

  @IBAction func singleAnswerButtonTapped(_ sender: UIButton) {
    let currentAnswers = question[questionIndex].answers
    guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
    let answer = currentAnswers[buttonIndex]
    answersChosen.append(answer)
    nextQuestion()
  }

  @IBAction func multipleAnswerButtonTapped() {
    let currentAnswers = question[questionIndex].answers
    for (multiSwitch, answer) in zip(multipleSwitch, currentAnswers) {
      if multiSwitch.isOn {
        answersChosen.append(answer)
      }
    }
    nextQuestion()
  }

  @IBAction func rangedButtonTapped(_ sender: UIButton) {
    let currentAnswers = question[questionIndex].answers
    let index = Int(rangedSlider.value * Float(currentAnswers.count - 1))
    answersChosen.append(currentAnswers[index])
    nextQuestion()
  }
}

// MARK: - Navigation
extension QuestionViewController {
/// Show next question or go to the next screen
  func nextQuestion() {
    questionIndex += 1

    if questionIndex < question.count {
      updateUI()
    } else {
      performSegue(withIdentifier: "ResultsSegue", sender: nil)
    }
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "ResultsSegue" else { return }
    guard let destination = segue.destination as? ResultsViewController else { return }
    destination.responses = answersChosen
  }
}


// MARK: - UIViewController Methods
extension QuestionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // set font size from User Defaults
    if UserDefaults.standard.contains(key: "FontSize") {
      fontSize = UserDefaults.standard.integer(forKey: "FontSize")
    }
    // update user interface
    for button in nextButtons {
      button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
    updateUI()
    }
  }

// MARK: - User Interface
extension QuestionViewController {

  /// Updates user interface
  func updateUI() {

    //hide all stack views
    for stackView in [singleStackView, multipleStackView, rangedStackView] {
      stackView?.isHidden = true
    }

    // get current question
    let currentQuestion = question[questionIndex]

    questionLabel.text = currentQuestion.text
    questionLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))

    // get current answer
    let currentAnswers = currentQuestion.answers

    // calculate progress
    let totalProgress = Float(questionIndex) / Float(question.count)

    // set progress for questionProgressView
    questionProgressView.setProgress(totalProgress, animated: true)

    // set navigation title
    navigationItem.title = "Question \(questionIndex + 1) of \(question.count)"

    // show stack view correcpondenting to question type
    switch currentQuestion.type {
    case .single:
      updateSingleStack(using: currentAnswers)
    case .multiple:
      updateMultipleStack(using: currentAnswers)
    case .ranged:
      updateRangedStack(using: currentAnswers)
    }
  }

  /// Setup single stack view
  ///
  /// - Parameter answers: [Answer] array with answers
  func updateSingleStack(using answers: [Answer]) {
    //show single stack view
    singleStackView.isHidden = false

    for (button, answer) in zip(singleButtons, answers) {
      button.setTitle(answer.text, for: [])
      button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
  }

  /// Setup multiple stack view
  ///
  /// - Parameter answers: [Answer] array with answers
  func updateMultipleStack(using answers: [Answer]) {
    //show multiple stack view
    multipleStackView.isHidden = false

    for (label, answer) in zip(multipleLabels, answers) {
      label.text = answer.text
      label.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
  }

  /// Setup ranged stack view
  ///
  /// - Parameter answers: [Answer] array with answers
  func updateRangedStack(using answers: [Answer]) {
    //show ranged stack view
    rangedStackView.isHidden = false

    rangedLabels.first?.text = answers.first?.text
    rangedLabels.first?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    rangedLabels.last?.text = answers.last?.text
    rangedLabels.last?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
  }
}

extension UserDefaults {
  func contains(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil      //object(forKey: key) != nil
  }
}
