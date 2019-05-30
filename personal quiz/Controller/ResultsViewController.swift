//
//  ResultsViewController.swift
//  personal quiz
//
//  Created by Sergiy Fugol on 5/25/17.
//  Copyright © 2019 Sergiy Fugol. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
  // MARK: IB Outlets
  @IBOutlet weak var resultAnswerLabel: UILabel!
  @IBOutlet weak var resultDefinitionLabel: UILabel!

  // MARK: - Stored Properties
  var responses: [Answer]!
  /// Font size by default
  var fontSize = 17

}

// MARK: - UIViewController Methods
extension ResultsViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // set font size from User Defaults
    if UserDefaults.standard.contains(key: "FontSize") {
      fontSize = UserDefaults.standard.integer(forKey: "FontSize")
    }
    navigationItem.hidesBackButton = true
    updateResult()
  }
}

// MARK: - Update User Interface
extension ResultsViewController {
  func updateResult() {
    var frequencyOfAnswers = [AnimalType: Int]()
    let responseType = responses.map { $0.type }

    for responce in responseType {
      frequencyOfAnswers[responce] = (frequencyOfAnswers[responce] ?? 0) + 1
    }
    let frequencyOfAnswersSorted = frequencyOfAnswers.sorted { $0.value > $1.value}
    guard let mostFrequentAnswer = frequencyOfAnswersSorted.first?.key else { return }

    updateUI(with: mostFrequentAnswer)
  }

  func updateUI(with animalType: AnimalType) {
    resultAnswerLabel.text = "You are - \(animalType.rawValue)!"
    resultAnswerLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    resultDefinitionLabel.text = animalType.definition
    resultDefinitionLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
  }
}
